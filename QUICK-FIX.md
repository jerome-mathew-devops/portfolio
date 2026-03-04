# ⚡ QUICK FIX - ERR_TIMED_OUT

## 🎯 THE PROBLEM:
Your site at https://jerome-mathew-devops.github.io/portfolio/ is timing out due to:
1. IPv6 connection failures (your system tries IPv6 first, fails, then times out)
2. Possible cached routing from old custom domain

## ✅ THE SOLUTION (3 COMMANDS):

```bash
cd /home/jay/Desktop/htmldemo.net/lendex
./fix-deployment.sh
```

**OR manually:**

```bash
cd /home/jay/Desktop/htmldemo.net/lendex
rm -f CNAME
git add -A
git commit -m "Fix GitHub Pages deployment"
git push origin main
```

## 🔧 THEN IN GITHUB:

1. Go to: https://github.com/jerome-mathew-devops/portfolio/settings/pages
2. Branch: Change to **"None"** → Save
3. Wait 30 seconds
4. Branch: Change to **"main"** → Save
5. Uncheck **"Enforce HTTPS"** → Save
6. Wait 2 minutes
7. Check **"Enforce HTTPS"** → Save
8. Wait 5 minutes

## 🧪 TEST IT:

```bash
# Test with IPv4 only (bypasses IPv6 timeout)
curl -4 -I https://jerome-mathew-devops.github.io/portfolio/

# Should return: HTTP/2 200
```

## 📊 YOUR CURRENT STATUS:

✅ Paths are RELATIVE (correct)
✅ .nojekyll exists
✅ Repository structure is fine
⚠️ IPv6 connection failing (causing timeout)
⚠️ Possible CNAME cache issue

## 🚨 WHY ABSOLUTE PATHS BREAK:

**Your site URL:** `https://jerome-mathew-devops.github.io/portfolio/lendex/`

**With absolute path `/assets/css/style.css`:**
- Browser looks for: `https://jerome-mathew-devops.github.io/assets/css/style.css`
- ❌ WRONG! (missing `/portfolio/lendex/`)

**With relative path `assets/css/style.css`:**
- Browser looks for: `https://jerome-mathew-devops.github.io/portfolio/lendex/assets/css/style.css`
- ✅ CORRECT!

**Your paths are already correct - no changes needed.**

## 📞 IF STILL NOT WORKING:

1. Clear browser cache: Ctrl+Shift+Delete
2. Flush DNS cache:
   ```bash
   sudo systemd-resolve --flush-caches
   ```
3. Try different browser
4. Check GitHub Actions: https://github.com/jerome-mathew-devops/portfolio/actions
5. Wait 10 minutes (GitHub Pages can be slow)

## 🎯 EXPECTED TIMELINE:

- **Immediate:** Script runs, pushes changes
- **2 minutes:** GitHub starts rebuild
- **5 minutes:** Site should be accessible
- **10 minutes:** Fully propagated globally

---

**Read GITHUB-PAGES-FIX.md for detailed explanation of each fix.**
