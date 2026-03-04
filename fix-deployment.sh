#!/bin/bash

echo "🚀 GitHub Pages Deployment Fix Script"
echo "======================================"
echo ""

# Navigate to repository
cd /home/jay/Desktop/htmldemo.net/lendex

# Check for CNAME
if [ -f "CNAME" ]; then
    echo "❌ Found CNAME file - removing it..."
    rm -f CNAME
    echo "✅ CNAME removed"
else
    echo "✅ No CNAME file found (good)"
fi

# Check for .nojekyll
if [ -f ".nojekyll" ]; then
    echo "✅ .nojekyll file exists"
else
    echo "⚠️  Creating .nojekyll file..."
    touch .nojekyll
    echo "✅ .nojekyll created"
fi

# Stage all changes
echo ""
echo "📦 Staging changes..."
git add -A

# Check if there are changes to commit
if git diff --staged --quiet; then
    echo "✅ No changes to commit - repository is clean"
else
    echo "💾 Committing changes..."
    git commit -m "Fix GitHub Pages deployment - remove CNAME and ensure .nojekyll exists"
    
    echo "🚀 Pushing to GitHub..."
    git push origin main
    
    echo ""
    echo "✅ Changes pushed successfully!"
fi

echo ""
echo "⏳ NEXT STEPS:"
echo "1. Go to: https://github.com/jerome-mathew-devops/portfolio/settings/pages"
echo "2. Change Branch to 'None' → Save → Wait 30 seconds"
echo "3. Change Branch back to 'main' → Save"
echo "4. Uncheck 'Enforce HTTPS' → Save → Wait 2 minutes"
echo "5. Check 'Enforce HTTPS' again → Save"
echo "6. Wait 5 minutes for rebuild"
echo "7. Test: https://jerome-mathew-devops.github.io/portfolio/"
echo ""
echo "🔍 Run diagnostic:"
echo "curl -4 -I https://jerome-mathew-devops.github.io/portfolio/"
