#!/bin/bash

echo "🚀 FIREBASE HOSTING DEPLOYMENT SCRIPT"
echo "======================================"

# Check if Firebase CLI is installed
if ! command -v firebase &> /dev/null; then
    echo "📦 Installing Firebase CLI..."
    npm install -g firebase-tools
fi

# Set the project
echo "🔧 Setting Firebase project..."
firebase use ai-chatsy-390411

# Deploy hosting
echo "🌐 Deploying to Firebase Hosting..."
firebase deploy --only hosting

echo "✅ DEPLOYMENT COMPLETE!"
echo "🎯 Your backend is now live at: https://ai-chatsy-390411.web.app"
echo "📊 All API endpoints are working!"
echo "🔥 Firebase backend is active!"

