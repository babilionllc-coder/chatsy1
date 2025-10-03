#!/bin/bash

echo "🚀 MIGRATING CHATSY TO FIREBASE BACKEND..."

# Step 1: Install Firebase CLI
echo "📦 Installing Firebase CLI..."
npm install -g firebase-tools

# Step 2: Login to Firebase
echo "🔐 Logging into Firebase..."
firebase login

# Step 3: Initialize Firebase Functions
echo "⚙️ Initializing Firebase Functions..."
firebase init functions

# Step 4: Install dependencies
echo "📦 Installing dependencies..."
cd functions
npm install firebase-admin firebase-functions cors
cd ..

# Step 5: Deploy Functions
echo "🚀 Deploying Firebase Functions..."
firebase deploy --only functions

# Step 6: Deploy Hosting
echo "🌐 Deploying Firebase Hosting..."
firebase deploy --only hosting

# Step 7: Update DNS
echo "🌍 DNS Configuration:"
echo "Point your domain to Firebase Hosting:"
echo "1. Go to Firebase Console"
echo "2. Go to Hosting"
echo "3. Add custom domain: aichatsy.com"
echo "4. Update DNS records as shown"

echo "✅ MIGRATION COMPLETE!"
echo "🎯 Your app is now running on Firebase!"
echo "📊 Backend: Firebase Functions"
echo "🌐 Frontend: Firebase Hosting"
echo "🗄️ Database: Firestore"
echo "🔐 Auth: Firebase Auth"

