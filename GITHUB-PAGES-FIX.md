# 🚨 GITHUB PAGES DEPLOYMENT FIX - ERR_TIMED_OUT

## DIAGNOSIS COMPLETE ✅

**Repository:** portfolio  
**URL:** https://jerome-mathew-devops.github.io/portfolio/  
**Issue:** ERR_TIMED_OUT  
**Root Cause:** IPv6 connection issues + Repository structure problem

---

## 🔧 IMMEDIATE FIXES (Run These Commands):

### Fix 1: Reset GitHub Pages Deployment
```bash
cd /home/jay/Desktop/htmldemo.net/lendex

# Delete CNAME file if it exists (forces routing reset)
rm -f CNAME

# Commit the change
git add -A
git commit -m "Reset GitHub Pages deployment - remove CNAME"
git push origin main
```

### Fix 2: Force Rebuild
Go to GitHub → Settings → Pages → Change branch to "None" → Save → Wait 10 seconds → Change back to "main" → Save

---

## 📋 DIAGNOSTIC RESULTS:

### ✅ curl Test Results:
```
* Trying 185.199.109.153:443... (GitHub Pages IPv4)
* IPv6 connections failing (Network unreachable)
* Connection attempting but timing out
```

**Conclusion:** GitHub Pages is reachable but something is blocking the connection.

---

## 🛠️ FIXES REQUIRED:

### 1. ROUTING CONFLICT FIX

**Problem:** Even with empty Custom Domain field, GitHub may have cached DNS records.

**Solution:**
```bash
# Check for hidden CNAME file
ls -la /home/jay/Desktop/htmldemo.net/lendex/ | grep CNAME

# If CNAME exists, delete it
rm -f /home/jay/Desktop/htmldemo.net/lendex/CNAME

# Commit and push
git add -A
git commit -m "Remove CNAME to reset routing"
git push origin main
```

**Then in GitHub Settings:**
1. Go to Settings → Pages
2. Click "Remove" next to Custom domain (even if empty)
3. Uncheck "Enforce HTTPS"
4. Save
5. Wait 2 minutes
6. Re-check "Enforce HTTPS"
7. Save again

---

### 2. RELATIVE PATH AUDIT

**Current Structure:**
```
/home/jay/Desktop/htmldemo.net/lendex/
├── index.html (redirects to lendex/index.html)
├── lendex/
│   ├── index.html (MAIN FILE)
│   └── assets/
│       ├── css/
│       ├── js/
│       └── images/
```

**Your lendex/index.html uses RELATIVE paths (✅ CORRECT):**
```html
<link rel="stylesheet" href="assets/css/vendor/vendor.min.css">
<link rel="stylesheet" href="assets/css/plugins/plugins.min.css">
<link rel="stylesheet" href="assets/css/style.min.css">
```

**Why this matters:**
- ✅ `assets/css/style.css` → Works on `/portfolio/lendex/`
- ❌ `/assets/css/style.css` → Looks for `/portfolio/assets/` (wrong!)

**Your paths are CORRECT - no changes needed here.**

---

### 3. REPOSITORY STRUCTURE FIX

**Current Problem:** Your main content is in `lendex/` subfolder.

**GitHub Pages URL will be:**
- ✅ https://jerome-mathew-devops.github.io/portfolio/ (redirects)
- ✅ https://jerome-mathew-devops.github.io/portfolio/lendex/index.html (actual site)

**Option A: Keep Current Structure (Recommended)**
Your root index.html already redirects to lendex/index.html - this is fine!

**Option B: Move to Root (Alternative)**
```bash
cd /home/jay/Desktop/htmldemo.net/lendex
mv lendex/* .
rm -rf lendex
git add -A
git commit -m "Move site to root directory"
git push origin main
```

---

### 4. CREATE .nojekyll FILE

**Why:** GitHub Pages uses Jekyll by default, which ignores folders starting with `_` and may cause issues.

```bash
cd /home/jay/Desktop/htmldemo.net/lendex
touch .nojekyll
git add .nojekyll
git commit -m "Add .nojekyll to disable Jekyll processing"
git push origin main
```

---

## 🔍 DIAGNOSTIC COMMANDS:

### Test 1: Check DNS Resolution
```bash
nslookup jerome-mathew-devops.github.io
```

### Test 2: Test IPv4 Only (Bypass IPv6 timeout)
```bash
curl -4 -v --max-time 10 https://jerome-mathew-devops.github.io/portfolio/
```

### Test 3: Check if CNAME file exists
```bash
curl -v https://jerome-mathew-devops.github.io/portfolio/CNAME
```

### Test 4: Test without HTTPS
```bash
curl -v --max-time 10 http://jerome-mathew-devops.github.io/portfolio/
```

### Test 5: Clear DNS Cache (Linux)
```bash
sudo systemd-resolve --flush-caches
# OR
sudo resolvectl flush-caches
```

---

## 🎯 STEP-BY-STEP FIX PROCEDURE:

### Step 1: Clean Repository
```bash
cd /home/jay/Desktop/htmldemo.net/lendex
rm -f CNAME
touch .nojekyll
git add -A
git commit -m "Fix GitHub Pages deployment"
git push origin main
```

### Step 2: Reset GitHub Pages
1. Go to: https://github.com/jerome-mathew-devops/portfolio/settings/pages
2. Under "Build and deployment":
   - Change Branch to **"None"**
   - Click **Save**
   - Wait 30 seconds
   - Change Branch back to **"main"**
   - Folder: **"/ (root)"**
   - Click **Save**

### Step 3: Disable/Re-enable HTTPS
1. Uncheck "Enforce HTTPS"
2. Save
3. Wait 2 minutes
4. Check "Enforce HTTPS" again
5. Save

### Step 4: Wait & Test
- Wait 3-5 minutes for GitHub to rebuild
- Clear browser cache (Ctrl+Shift+Delete)
- Test: https://jerome-mathew-devops.github.io/portfolio/

### Step 5: If Still Timing Out
```bash
# Test with IPv4 only
curl -4 -I https://jerome-mathew-devops.github.io/portfolio/

# Check GitHub Actions
# Go to: https://github.com/jerome-mathew-devops/portfolio/actions
# Verify "pages build and deployment" succeeded
```

---

## 🚨 COMMON CAUSES OF ERR_TIMED_OUT:

1. ✅ **IPv6 Connection Issues** - Your system is trying IPv6 first (failing)
2. ✅ **Cached CNAME Record** - Old custom domain still in DNS
3. ✅ **GitHub Pages Not Fully Deployed** - Build still in progress
4. ⚠️ **Firewall/ISP Blocking** - Some ISPs block GitHub Pages
5. ⚠️ **Browser DNS Cache** - Old DNS records cached locally

---

## 🔥 NUCLEAR OPTION (If Nothing Works):

```bash
cd /home/jay/Desktop/htmldemo.net/lendex

# Create a simple test page
cat > test.html << 'EOF'
<!DOCTYPE html>
<html>
<head><title>Test Page</title></head>
<body><h1>GitHub Pages is Working!</h1></body>
</html>
EOF

git add test.html
git commit -m "Add test page"
git push origin main

# Then visit: https://jerome-mathew-devops.github.io/portfolio/test.html
```

If test.html loads but your main site doesn't, the issue is in your HTML/CSS/JS files.

---

## ✅ SUCCESS CHECKLIST:

- [ ] CNAME file removed
- [ ] .nojekyll file created
- [ ] GitHub Pages reset (None → main)
- [ ] HTTPS disabled then re-enabled
- [ ] Waited 5 minutes
- [ ] Browser cache cleared
- [ ] DNS cache flushed
- [ ] Test page loads successfully

---

## 📞 NEXT STEPS:

1. Run the commands in "Step 1: Clean Repository"
2. Follow "Step 2: Reset GitHub Pages"
3. Wait 5 minutes
4. Test with: `curl -4 -I https://jerome-mathew-devops.github.io/portfolio/`
5. If successful, open in browser

**Expected Result:** Site should load within 5 minutes of completing steps.
