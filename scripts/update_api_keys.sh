#!/bin/bash

# Chatsy API Keys Update Script
# This script helps update API keys securely

echo "🔐 Chatsy API Keys Update Script"
echo "================================="

# Check if .env file exists
if [ ! -f ".env" ]; then
    echo "📝 Creating .env file from template..."
    cp env.example .env
    echo "✅ .env file created. Please edit it with your API keys."
fi

echo ""
echo "📋 Current API Keys Status:"
echo "---------------------------"

# Check if API keys are configured
if grep -q "your_.*_api_key_here" .env; then
    echo "⚠️  Some API keys need to be configured in .env file"
else
    echo "✅ All API keys appear to be configured"
fi

echo ""
echo "🔧 Available Commands:"
echo "1. Edit .env file: nano .env"
echo "2. View current keys: cat .env"
echo "3. Backup keys: cp .env .env.backup"
echo "4. Restore keys: cp .env.backup .env"

echo ""
echo "⚠️  Security Reminders:"
echo "- Never commit .env file to version control"
echo "- Keep your API keys secure"
echo "- Use different keys for development and production"
echo "- Regularly rotate your API keys"

echo ""
echo "🚀 To apply changes, restart the Flutter app"