#!/bin/bash

echo "🚀 Moving /lendex contents to root directory"
echo "============================================"
echo ""

cd /home/jay/Desktop/htmldemo.net/lendex

# Step 1: Backup current root index.html (the redirect page)
echo "📦 Step 1: Backing up root index.html..."
if [ -f "index.html" ]; then
    mv index.html index.html.backup
    echo "✅ Backed up to index.html.backup"
fi

# Step 2: Move all contents from lendex/ to root
echo ""
echo "📦 Step 2: Moving lendex/* to root..."
mv lendex/* .
echo "✅ All files moved"

# Step 3: Remove empty lendex directory
echo ""
echo "📦 Step 3: Removing empty lendex/ directory..."
rmdir lendex
echo "✅ Directory removed"

# Step 4: Ensure .nojekyll is in root (it already is)
echo ""
echo "📦 Step 4: Verifying .nojekyll..."
if [ -f ".nojekyll" ]; then
    echo "✅ .nojekyll exists in root"
else
    touch .nojekyll
    echo "✅ .nojekyll created"
fi

# Step 5: Stage all changes
echo ""
echo "📦 Step 5: Staging changes for git..."
git add -A
echo "✅ Changes staged"

# Step 6: Show what will be committed
echo ""
echo "📋 Files to be committed:"
git status --short

echo ""
echo "✅ READY TO COMMIT!"
echo ""
echo "🎯 Next steps:"
echo "1. Review the changes above"
echo "2. Run: git commit -m 'Move site from /lendex to root directory'"
echo "3. Run: git push origin main"
echo "4. Wait 2-3 minutes for GitHub Pages to rebuild"
echo "5. Visit: https://jerome-mathew-devops.github.io/portfolio/"
echo ""
echo "⚠️  Your asset paths are already relative (assets/css/...) so they will work correctly!"
