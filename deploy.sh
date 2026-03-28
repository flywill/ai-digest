#!/bin/bash

# AI Builders Digest Deployment Script
# This script handles the deployment process for AI Builders Digest

set -e

echo "🚀 Starting AI Builders Digest deployment..."

# Check if we're in the right directory
if [ ! -f "index.html" ]; then
    echo "❌ Error: index.html not found. Are you in the ai-digest-project directory?"
    exit 1
fi

echo "📝 Committing changes..."
git add -A
git commit -m "Update AI Builders Digest - $(date '+%Y-%m-%d %H:%M:%S')"

echo "🔄 Pushing to GitHub..."
# Try to push, if it fails, provide instructions
if ! git push origin main 2>/dev/null; then
    echo "⚠️  Git push failed. You need to authenticate with GitHub."
    echo ""
    echo "Please choose an authentication method:"
    echo ""
    echo "Option 1: Use Personal Access Token (Recommended)"
    echo "  1. Go to https://github.com/settings/tokens"
    echo "  2. Generate a new token with 'repo' scope"
    echo "  3. Run: git push https://YOUR_TOKEN@github.com/flywill/ai-digest.git main"
    echo ""
    echo "Option 2: Setup SSH Keys (Best for long-term)"
    echo "  1. Run: ssh-keygen -t ed25519 -C 'your_email@example.com'"
    echo "  2. Copy the public key: cat ~/.ssh/id_ed25519.pub"
    echo "  3. Add it to GitHub Settings > SSH and GPG keys"
    echo "  4. Test: ssh -T git@github.com"
    echo ""
    echo "Option 3: Use GitHub CLI"
    echo "  1. Install: brew install gh (macOS) or visit https://cli.github.com/"
    echo "  2. Authenticate: gh auth login"
    echo "  3. Push: git push origin main"
    echo ""
    exit 1
fi

echo "✅ Code pushed to GitHub successfully!"
echo ""
echo "🌐 Vercel will automatically deploy the changes."
echo "   Visit: https://ai-digest-psi.vercel.app"
echo "   Or: https://vercel.com/flywill/ai-digest"
echo ""
echo "⏱️  Deployment usually takes 30-60 seconds."
echo "   You can monitor progress at the Vercel dashboard."
