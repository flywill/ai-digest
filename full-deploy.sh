#!/bin/bash

# Complete Deployment Script for AI Builders Digest
# This script handles all aspects of deployment to Vercel via GitHub

set -e

PROJECT_DIR="$HOME/ai-digest-project"
cd "$PROJECT_DIR"

echo "🚀 AI Builders Digest - Complete Deployment"
echo "=========================================="
echo ""

# Check files
echo "📋 Checking files..."
if [ ! -f "index.html" ]; then
    echo "❌ Error: index.html not found"
    exit 1
fi
echo "✅ index.html found"

if [ ! -f "vercel.json" ]; then
    echo "❌ Error: vercel.json not found"
    exit 1
fi
echo "✅ vercel.json found"

echo ""

# Stage all changes
echo "📝 Staging changes..."
git add -A
echo "✅ Changes staged"

# Check if there are changes to commit
if git diff --cached --quiet; then
    echo "⚠️  No changes to commit. Everything is up to date."
    echo "   If you want to force deploy, make a change first."
    exit 0
fi

# Commit changes
echo "💾 Committing changes..."
git commit -m "Update AI Builders Digest - $(date '+%Y-%m-%d %H:%M:%S')" -m "Auto-deployed from automation"
echo "✅ Changes committed"

# Attempt deployment with multiple methods
echo ""
echo "🔄 Attempting to push to GitHub..."
echo ""

# Method 1: Try standard git push
if git push origin main 2>/dev/null; then
    echo "✅ Successfully pushed to GitHub!"
    echo ""
    echo "🌐 Vercel will automatically deploy your changes."
    echo "   Website: https://ai-digest-psi.vercel.app"
    echo ""
    echo "⏱️  Deployment typically takes 30-60 seconds."
    echo "   Monitor at: https://vercel.com/flywill/ai-digest"
    exit 0
fi

# Method 2: If that failed, try with GitHub CLI
if command -v gh &> /dev/null; then
    echo "🔧 Trying GitHub CLI..."
    if gh auth status &> /dev/null; then
        echo "   GitHub CLI is authenticated"
        gh repo set-default flywill/ai-digest
        if git push origin main 2>/dev/null; then
            echo "✅ Successfully pushed via GitHub CLI!"
            echo ""
            echo "🌐 Website: https://ai-digest-psi.vercel.app"
            exit 0
        fi
    else
        echo "   GitHub CLI not authenticated. Run: gh auth login"
    fi
fi

# If all methods failed, provide manual instructions
echo ""
echo "⚠️  Automatic deployment failed. Manual steps required:"
echo ""
echo "📋 To complete deployment, choose one of these methods:"
echo ""
echo "Method 1: Set up Git credentials and push"
echo "  1. Configure git credentials:"
echo "     git config --global user.name 'Your Name'"
echo "     git config --global user.email 'your.email@example.com'"
echo "  2. Set up GitHub authentication:"
echo "     Option A - Personal Access Token:"
echo "       - Create token at: https://github.com/settings/tokens"
echo "       - Add 'repo' scope"
echo "       - Push: git push https://TOKEN@github.com/flywill/ai-digest.git main"
echo "     Option B - SSH Keys:"
echo "       - Run: ssh-keygen -t ed25519 -C 'your.email@example.com'"
echo "       - Copy public key: cat ~/.ssh/id_ed25519.pub"
echo "       - Add to GitHub: Settings > SSH and GPG keys"
echo "       - Test: ssh -T git@github.com"
echo ""
echo "Method 2: Install GitHub CLI"
echo "  1. Install: brew install gh"
echo "  2. Login: gh auth login"
echo "  3. Push: git push origin main"
echo ""
echo "Method 3: Direct Vercel deployment"
echo "  1. Install Vercel CLI: npm i -g vercel"
echo "  2. Login: vercel login"
echo "  3. Deploy: vercel --prod"
echo ""
echo "📊 Current Git status:"
git status
echo ""
echo "🌐 Once deployed, visit: https://ai-digest-psi.vercel.app"
