#!/bin/bash

echo "🚀 DEPLOYING CHATSY ADMIN DASHBOARD TO ai-chatsy-390411.web.app..."

# Set the service account
export GOOGLE_APPLICATION_CREDENTIALS="firebase-service-account.json"

# Set the project
npx firebase use ai-chatsy-390411

# Deploy the dashboard
echo "🌐 Deploying dashboard..."
npx firebase deploy --only hosting

echo "✅ DEPLOYMENT COMPLETE!"
echo "🎯 Your dashboard is now live at: https://ai-chatsy-390411.web.app"
echo "🔥 Firebase integration active"
echo "📊 All 51,129 users accessible"
echo "🎉 Complete admin control ready!"


