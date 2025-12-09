// Service Worker for SPC Online
// Provides offline functionality for prayers

const CACHE_NAME = 'spc-online-v72';
const RUNTIME_CACHE = 'spc-runtime-v72';

// Essential files to cache immediately
const PRECACHE_ASSETS = [
  '/spconline/',
  '/spconline/index.html',
  '/spconline/landing.html',
  '/spconline/prayer-stats.html',
  '/spconline/prayer-settings.html',
  '/spconline/footer.html',
  '/spconline/navbar.html',
  '/spconline/css/clean-blog.min.css',
  '/spconline/css/theme.css',
  '/spconline/css/dark-mode.css',
  '/spconline/css/modern-theme.css',
  '/spconline/js/app.js',
  '/spconline/js/font-size.js',
  '/spconline/js/bookmarks.js',
  '/spconline/js/search.js',
  '/spconline/js/footer-loader.js',
  '/spconline/js/navbar-loader.js',
  '/spconline/js/prayer-enhancer.js',
  '/spconline/js/prayer-tracker.js',
  '/spconline/vendor/jquery/jquery.min.js',
  '/spconline/vendor/bootstrap/js/bootstrap.bundle.min.js',
  '/spconline/vendor/bootstrap/css/bootstrap.min.css',
  '/spconline/js/clean-blog.min.js'
];

// Install event - cache essential files
self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then((cache) => {
        return cache.addAll(PRECACHE_ASSETS);
      })
      .then(() => self.skipWaiting())
  );
});

// Activate event - clean up old caches
self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((cacheName) => {
          if (cacheName !== CACHE_NAME && cacheName !== RUNTIME_CACHE) {
            return caches.delete(cacheName);
          }
        })
      );
    }).then(() => self.clients.claim())
  );
});

// Fetch event - serve from cache, fallback to network
self.addEventListener('fetch', (event) => {
  const { request } = event;
  const url = new URL(request.url);

  // Skip cross-origin requests
  if (url.origin !== location.origin) {
    return;
  }

  // Strategy: Cache First (for offline capability)
  event.respondWith(
    caches.match(request)
      .then((cachedResponse) => {
        if (cachedResponse) {
          return cachedResponse;
        }

        // Not in cache, fetch from network
        return fetch(request)
          .then((response) => {
            // Don't cache non-successful responses
            if (!response || response.status !== 200 || response.type === 'error') {
              return response;
            }

            // Clone the response
            const responseToCache = response.clone();

            // Cache prayer pages, images, and other assets
            if (
              request.url.includes('.html') ||
              request.url.includes('.jpg') ||
              request.url.includes('.png') ||
              request.url.includes('.css') ||
              request.url.includes('.js')
            ) {
              caches.open(RUNTIME_CACHE)
                .then((cache) => {
                  cache.put(request, responseToCache);
                });
            }

            return response;
          })
          .catch((error) => {
            
            // Return offline page for HTML requests
            if (request.destination === 'document') {
              return caches.match('/spconline/landing.html');
            }
          });
      })
  );
});

// Listen for messages from the app
self.addEventListener('message', (event) => {
  if (event.data && event.data.type === 'SKIP_WAITING') {
    self.skipWaiting();
  }
  
  if (event.data && event.data.type === 'CACHE_PRAYERS') {
    // Cache all prayer pages for offline use
    const prayerUrls = event.data.urls || [];
    caches.open(CACHE_NAME)
      .then((cache) => {
        return cache.addAll(prayerUrls);
      })
      .then(() => {
      });
  }
});
