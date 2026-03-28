#!/bin/bash

# Vercel Deploy Hook Trigger Script
# This script triggers Vercel deployment using a Deploy Hook

# ⚠️  IMPORTANT: Replace this URL with your actual Vercel Deploy Hook URL
# Get it from: Vercel Dashboard > Project Settings > Git > Deploy Hooks > Create Hook
DEPLOY_HOOK_URL="YOUR_VERCEL_DEPLOY_HOOK_URL_HERE"

PROJECT_DIR="$HOME/ai-digest-project"
cd "$PROJECT_DIR"

echo "🚀 AI Builders Digest - Vercel Deployment Trigger"
echo "=================================================="
echo ""

# Check if hook URL is configured
if [[ "$DEPLOY_HOOK_URL" == *"YOUR_VERCEL_DEPLOY_HOOK_URL_HERE"* ]]; then
    echo "❌ Error: Vercel Deploy Hook URL not configured!"
    echo ""
    echo "📋 Setup Instructions:"
    echo "   1. Go to: https://vercel.com/flywill/ai-digest/settings/git"
    echo "   2. Find 'Deploy Hooks' section"
    echo "   3. Click 'Create Hook'"
    echo "   4. Name it: 'auto-digest'"
    echo "   5. Copy the generated URL"
    echo "   6. Edit this file: ~/ai-digest-project/trigger-deploy.sh"
    echo "   7. Replace YOUR_VERCEL_DEPLOY_HOOK_URL_HERE with the actual URL"
    echo ""
    exit 1
fi

# Verify files exist
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

# Trigger deployment
echo "🔄 Triggering Vercel deployment..."
echo "   Hook URL: ${DEPLOY_HOOK_URL:0:50}..."
echo ""

# Use curl to trigger the deploy hook
RESPONSE=$(curl -s -X POST "$DEPLOY_HOOK_URL" \
  -H "Content-Type: application/json" \
  -H "User-Agent: AI-Builders-Digest-Automation")

# Check if deployment was triggered successfully
if [ $? -eq 0 ]; then
    echo "✅ Deployment trigger successful!"
    echo ""
    echo "📊 Deployment Response:"
    echo "$RESPONSE"
    echo ""
    echo "🌐 Your website will be available at:"
    echo "   https://ai-digest-psi.vercel.app"
    echo ""
    echo "⏱️  Deployment typically takes 30-60 seconds."
    echo "   Monitor progress at: https://vercel.com/flywill/ai-digest"
    echo ""
else
    echo "❌ Failed to trigger deployment"
    echo "   Response: $RESPONSE"
    echo ""
    echo "🔧 Troubleshooting:"
    echo "   - Check if the Deploy Hook URL is correct"
    echo "   - Verify your internet connection"
    echo "   - Check Vercel dashboard for any errors"
    exit 1
fi
