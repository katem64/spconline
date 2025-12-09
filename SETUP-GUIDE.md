# SPC Online - PWA Setup & Testing Guide

## 🎉 What Has Been Created

Your SPC Online website has been successfully enhanced with Progressive Web App (PWA) capabilities while preserving all existing content and structure.

### ✅ Files Created:

**PWA Core:**
- `manifest.json` - PWA configuration
- `sw.js` - Service Worker for offline functionality

**Enhanced Styles:**
- `css/theme.css` - Modern, dignified design improvements
- `css/dark-mode.css` - Night mode for evening prayers

**Feature Scripts:**
- `js/app.js` - Main PWA controller
- `js/font-size.js` - Adjustable text size (4 options)
- `js/bookmarks.js` - Save favorite prayers
- `js/search.js` - Search all prayers

**Icon Tools:**
- `icon-generator.html` - Generate all required app icons
- `icons/README.md` - Icon creation instructions

**Updated:**
- `index.html` - Added PWA features and links

---

## 🚀 Setup Instructions

### Step 1: Generate App Icons

1. Open `http://localhost/spconline/icon-generator.html` in your browser
2. Choose your preferred icon design (Cross recommended)
3. Customize colors if desired (defaults are already set)
4. Click "Generate All Icons"
5. Download all 8 icons (or click "Download All as ZIP")
6. Place all downloaded icons in the `/spconline/icons/` folder

The icons will be named:
- `icon-72.png`
- `icon-96.png`
- `icon-128.png`
- `icon-144.png`
- `icon-152.png`
- `icon-192.png`
- `icon-384.png`
- `icon-512.png`

### Step 2: Test Locally

1. Make sure XAMPP is running
2. Navigate to `http://localhost/spconline/`
3. You should see:
   - New controls bar below the header (Dark Mode, Search, Font Size, Bookmark buttons)
   - Improved color scheme (no more light yellow!)
   - Smoother, more modern design

### Step 3: Test PWA Features

**Test Service Worker:**
1. Open Chrome DevTools (F12)
2. Go to Application > Service Workers
3. You should see `sw.js` registered and running
4. Status should be "activated and is running"

**Test Offline Mode:**
1. Browse a few prayer pages
2. Go to DevTools > Network tab
3. Check "Offline" checkbox
4. Navigate to prayers you've already visited
5. They should still load!

**Test Dark Mode:**
1. Click the "Night Mode" button in controls
2. Page should switch to dark theme with warm colors
3. Refresh page - dark mode should persist

**Test Font Size:**
1. Click the "A" buttons (small to extra large)
2. Text size should adjust immediately
3. Refresh page - size preference should persist

**Test Bookmarks:**
1. Go to any prayer page
2. Click "Bookmark" button
3. Click bookmark button again to see your saved prayers
4. Remove bookmarks by clicking X

**Test Search:**
1. Click "Search" button or press Ctrl+K (Cmd+K on Mac)
2. Type a prayer name (e.g., "rosary", "morning", "st paul")
3. Results should appear instantly
4. Click a result to navigate to that prayer

---

## 📱 Testing on Mobile Devices

### Android (Chrome):

1. **Access from mobile:**
   - Connect phone to same network as computer
   - Find your computer's IP address (run `ipconfig` in Command Prompt)
   - Access `http://YOUR_IP/spconline/` from phone

2. **Test PWA features:**
   - Browse a few prayers
   - You'll see "Add to Home Screen" prompt
   - Install the app
   - App opens in standalone mode (no browser UI)
   - Test offline by turning off WiFi

3. **Test mobile controls:**
   - All buttons should be large enough to tap easily
   - Dropdown menus should be scrollable
   - Search should work on mobile keyboard

### iOS (Safari):

1. **Access from iPhone/iPad:**
   - Same IP address method as Android

2. **Install:**
   - Tap Share button
   - Select "Add to Home Screen"
   - App appears on home screen with your icon

3. **Test:**
   - Open from home screen
   - Should look like native app
   - Test all features (dark mode, bookmarks, etc.)

---

## 🌐 Deploying to Live Server

### Requirements for PWA:
- **HTTPS required** (PWAs don't work on HTTP in production)
- Free SSL from Let's Encrypt or CloudFlare

### Deployment Steps:

1. **Upload all files** to your web server
2. **Ensure HTTPS** is enabled
3. **Test manifest** at `https://yourdomain.com/spconline/manifest.json`
4. **Test service worker** registration in DevTools

### Recommended Hosting:
- **Netlify** (Free, automatic HTTPS)
- **GitHub Pages** (Free, HTTPS included)
- **Vercel** (Free, HTTPS included)
- **CloudFlare Pages** (Free, HTTPS included)

---

## 🔍 Verification Checklist

### PWA Installation:
- [ ] manifest.json loads without errors
- [ ] All 8 icons exist in /icons/ folder
- [ ] Service worker registers successfully
- [ ] "Add to Home Screen" prompt appears (after visiting site)
- [ ] App installs on mobile device
- [ ] App opens in standalone mode

### Features Working:
- [ ] Dark mode toggles and persists
- [ ] Font size adjusts and persists
- [ ] Bookmarks save and load correctly
- [ ] Search finds prayers accurately
- [ ] Offline mode works (visited pages load)
- [ ] All dropdown menus work on mobile

### Design Quality:
- [ ] No light yellow background (replaced with soft linen)
- [ ] Smooth transitions and animations
- [ ] High contrast text (readable)
- [ ] Mobile responsive (tested on phone)
- [ ] Touch targets large enough (48px minimum)
- [ ] Dark mode colors are comfortable for night reading

---

## 🎨 Customization Options

### Change Theme Colors:

Edit `css/theme.css` and modify CSS variables:

```css
:root {
  --color-primary: #8B4513;      /* Main brown */
  --color-secondary: #4A5568;    /* Slate blue */
  --color-accent: #B8860B;       /* Gold */
  --color-bg: #FAF9F6;          /* Background */
}
```

### Change Dark Mode Colors:

Edit `css/dark-mode.css`:

```css
body.dark-mode {
  --color-primary: #D4A574;      /* Light brown */
  --color-bg: #1a1a1a;          /* Very dark gray */
  --color-text: #E8E6E3;        /* Off-white */
}
```

### Modify Font Sizes:

Edit `js/font-size.js` to change the 4 available sizes.

---

## 🐛 Troubleshooting

### Service Worker Not Registering:
- Check browser console for errors
- Ensure path is correct: `/spconline/sw.js`
- Clear browser cache and reload
- Check if service workers are enabled in browser

### Icons Not Showing:
- Verify all 8 icons exist in `/icons/` folder
- Check file names match exactly (case-sensitive)
- Clear cache and reload
- Check manifest.json in DevTools > Application > Manifest

### Dark Mode Not Working:
- Check if localStorage is enabled in browser
- Open DevTools > Application > Local Storage
- Look for `spc-dark-mode` key
- Check if `dark-mode.css` is loaded

### Search Not Finding Prayers:
- Check browser console for JavaScript errors
- Verify `search.js` is loaded
- Test with simple queries like "mary" or "prayer"

### Bookmarks Not Saving:
- Check localStorage is enabled
- Check browser console for errors
- Try in incognito/private mode to test fresh
- Check if `bookmarks.js` is loaded

### Offline Mode Not Working:
- Visit pages first (they need to be cached)
- Check service worker status in DevTools
- Look at Cache Storage in DevTools > Application
- Wait a few seconds after first visit for caching

---

## 📊 Performance Optimization (Optional)

### Image Optimization:
The images in `/img/` folder can be optimized:

1. **Compress JPGs** to 80% quality
2. **Resize** to actual display size
3. **Convert to WebP** for modern browsers
4. Use tools like TinyPNG or Squoosh

### Lazy Loading:
Add to images that are below the fold:
```html
<img src="image.jpg" loading="lazy" alt="...">
```

---

## 📝 Next Steps

### Optional Enhancements:

1. **Add to other pages:**
   - Copy the PWA links from `index.html` `<head>` to all other HTML files
   - This ensures features work on all pages, not just homepage

2. **Prayer of the Day:**
   - Add time-based recommendations
   - Suggest morning prayers at 6 AM, etc.

3. **Rosary Counter:**
   - Add bead-by-bead tracking
   - Vibration on decade completion

4. **Audio Prayers:**
   - Record prayer audio
   - Add play/pause controls
   - For visually impaired sisters

5. **Multi-language:**
   - Language switcher
   - Store preference
   - Use existing Latin/French prayers

6. **Prayer Reminders:**
   - Browser notifications
   - Angelus at noon
   - Night prayer reminder

---

## 🙏 Features Summary

### What Sisters Can Now Do:

✅ **Access prayers offline** - No internet needed after first visit
✅ **Install on phone** - Like a native app
✅ **Night mode** - Easy on eyes for evening prayers
✅ **Adjust text size** - 4 sizes for all ages
✅ **Bookmark favorites** - Quick access to frequent prayers
✅ **Search instantly** - Find any prayer in seconds
✅ **Modern design** - Clean, dignified, professional
✅ **Mobile-friendly** - Works perfectly on phones/tablets
✅ **Fast loading** - Cached for instant access
✅ **Privacy-focused** - Everything stored locally, no tracking

---

## 📞 Support

If you encounter issues:

1. Check browser console for error messages
2. Verify all files are in correct locations
3. Clear browser cache and try again
4. Test in incognito/private mode
5. Try different browser (Chrome works best for PWAs)

---

## 🎊 Congratulations!

Your SPC Online prayer companion is now a modern, offline-capable Progressive Web App! 

The Sisters of St. Paul of Chartres can now:
- Pray anywhere, anytime (even without internet)
- Enjoy comfortable reading in night mode
- Find prayers instantly with search
- Customize their experience
- Use it like a native app on their devices

**May this digital prayer companion serve the spiritual needs of the community!** 🙏

---

**Version:** 1.0.0  
**Last Updated:** December 7, 2025  
**Maintained by:** SPC Philippine Province
