# 🚀 Quick Start Guide - SPC Online PWA

## ⚡ 3 Steps to Get Started

### 1️⃣ Generate Icons (5 minutes)
```
1. Open: http://localhost/spconline/icon-generator.html
2. Click "Generate All Icons"
3. Download all 8 icons
4. Save to: /spconline/icons/ folder
```

### 2️⃣ Test Locally (2 minutes)
```
1. Start XAMPP (Apache running)
2. Open: http://localhost/spconline/
3. You should see new controls below header
4. Test dark mode, search, and bookmarks
```

### 3️⃣ Test on Mobile (5 minutes)
```
1. Find your computer IP: ipconfig (Windows) or ifconfig (Mac/Linux)
2. On phone: http://YOUR_IP/spconline/
3. Install: "Add to Home Screen"
4. Open app from home screen
```

---

## 🎯 What's New?

### 🌙 **Dark Mode**
- Click "Night Mode" button
- Perfect for evening prayers
- Automatically saves preference

### 🔍 **Search**
- Click "Search" or press `Ctrl+K`
- Find any prayer instantly
- Works offline

### 📖 **Font Sizes**
- 4 size options (A buttons)
- From small to extra large
- Perfect for all ages

### ⭐ **Bookmarks**
- Star your favorite prayers
- Quick access anytime
- Saved locally

### 📴 **Offline Mode**
- Visit prayers once
- Access anytime without internet
- Perfect for chapels without WiFi

---

## ✅ Quick Checklist

**Before Testing:**
- [ ] XAMPP Apache is running
- [ ] Icons generated and saved
- [ ] Browser cache cleared

**After Testing:**
- [ ] Dark mode works
- [ ] Search finds prayers
- [ ] Font size adjusts
- [ ] Bookmarks save
- [ ] Service worker registered (check DevTools)

---

## 🐛 Quick Fixes

**Service Worker Error?**
→ Clear cache, reload page

**Icons Missing?**
→ Check `/icons/` folder has 8 PNG files

**Dark Mode Not Saving?**
→ Check localStorage enabled in browser

**Search Not Working?**
→ Open console (F12), check for errors

**Can't Install on Phone?**
→ Needs HTTPS in production (works on localhost for testing)

---

## 📱 Testing URLs

| Environment | URL |
|------------|-----|
| Local PC | `http://localhost/spconline/` |
| Mobile (same WiFi) | `http://YOUR_IP/spconline/` |
| Icon Generator | `http://localhost/spconline/icon-generator.html` |

---

## 🎨 Key Features for Sisters

✨ **No Internet Needed** - After first visit  
✨ **Night Prayer Mode** - Easy on eyes  
✨ **Large Text Option** - For aging eyes  
✨ **Quick Search** - Find prayers fast  
✨ **Bookmark Favorites** - One-tap access  
✨ **Mobile Friendly** - Works on any device  
✨ **Privacy First** - Everything stored locally  

---

## 📞 Need Help?

1. Check `SETUP-GUIDE.md` for detailed instructions
2. Check browser console (F12) for errors
3. Test in Chrome (best PWA support)
4. Clear cache and try again

---

## 🎊 Done!

**Your SPC Online is now a modern PWA!**

Next: Test all features, then deploy to live server with HTTPS.

**For detailed documentation, see `SETUP-GUIDE.md`**

---

**Quick Tip:** Press `Ctrl+K` (or `Cmd+K` on Mac) from anywhere to open search! ⚡
