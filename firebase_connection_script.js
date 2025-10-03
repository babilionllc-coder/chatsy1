// 🔥 FIREBASE DATABASE CONNECTION SCRIPT
// Project: ai-chatsy-390411
// 
// This script helps you connect to your Firebase database and view users
// Run with: node firebase_connection_script.js

const admin = require('firebase-admin');

// Your Firebase project configuration
const serviceAccount = {
  "type": "service_account",
  "project_id": "ai-chatsy-390411",
  "private_key_id": "YOUR_PRIVATE_KEY_ID", // Get from Firebase Console
  "private_key": "YOUR_PRIVATE_KEY", // Get from Firebase Console
  "client_email": "YOUR_CLIENT_EMAIL", // Get from Firebase Console
  "client_id": "YOUR_CLIENT_ID", // Get from Firebase Console
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "YOUR_CLIENT_X509_CERT_URL" // Get from Firebase Console
};

// Initialize Firebase Admin SDK
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  projectId: 'ai-chatsy-390411'
});

const auth = admin.auth();
const db = admin.firestore();

async function getAllUsers() {
  try {
    console.log('🔥 Connecting to Firebase Database...');
    console.log('📊 Project ID: ai-chatsy-390411');
    console.log('=====================================');
    
    // List all users
    const listUsersResult = await auth.listUsers();
    
    console.log(`👥 Total Users Found: ${listUsersResult.users.length}`);
    console.log('=====================================');
    
    listUsersResult.users.forEach((user, index) => {
      console.log(`\n👤 User ${index + 1}:`);
      console.log(`   UID: ${user.uid}`);
      console.log(`   Email: ${user.email || 'N/A'}`);
      console.log(`   Display Name: ${user.displayName || 'N/A'}`);
      console.log(`   Phone: ${user.phoneNumber || 'N/A'}`);
      console.log(`   Email Verified: ${user.emailVerified}`);
      console.log(`   Created: ${user.metadata.creationTime}`);
      console.log(`   Last Sign In: ${user.metadata.lastSignInTime}`);
      console.log(`   Providers: ${user.providerData.map(p => p.providerId).join(', ')}`);
      console.log(`   Disabled: ${user.disabled}`);
    });
    
    // Get user statistics
    const stats = {
      total: listUsersResult.users.length,
      emailVerified: listUsersResult.users.filter(u => u.emailVerified).length,
      googleUsers: listUsersResult.users.filter(u => u.providerData.some(p => p.providerId === 'google.com')).length,
      appleUsers: listUsersResult.users.filter(u => u.providerData.some(p => p.providerId === 'apple.com')).length,
      emailUsers: listUsersResult.users.filter(u => u.providerData.some(p => p.providerId === 'password')).length,
      disabled: listUsersResult.users.filter(u => u.disabled).length,
    };
    
    console.log('\n📊 USER STATISTICS:');
    console.log('=====================================');
    console.log(`Total Users: ${stats.total}`);
    console.log(`Email Verified: ${stats.emailVerified}`);
    console.log(`Google Sign-in: ${stats.googleUsers}`);
    console.log(`Apple Sign-in: ${stats.appleUsers}`);
    console.log(`Email/Password: ${stats.emailUsers}`);
    console.log(`Disabled Accounts: ${stats.disabled}`);
    
    return listUsersResult.users;
    
  } catch (error) {
    console.error('❌ Error accessing Firebase:', error);
    throw error;
  }
}

async function exportUsersToCSV(users) {
  const csv = [
    'UID,Email,Display Name,Phone,Email Verified,Created,Last Sign In,Providers,Disabled'
  ];
  
  users.forEach(user => {
    csv.push([
      user.uid,
      user.email || '',
      user.displayName || '',
      user.phoneNumber || '',
      user.emailVerified,
      user.metadata.creationTime,
      user.metadata.lastSignInTime,
      user.providerData.map(p => p.providerId).join(';'),
      user.disabled
    ].join(','));
  });
  
  const fs = require('fs');
  fs.writeFileSync('firebase_users_export.csv', csv.join('\n'));
  console.log('\n💾 Users exported to firebase_users_export.csv');
}

// Main execution
async function main() {
  try {
    const users = await getAllUsers();
    
    // Ask if user wants to export
    const readline = require('readline');
    const rl = readline.createInterface({
      input: process.stdin,
      output: process.stdout
    });
    
    rl.question('\n💾 Export users to CSV? (y/n): ', async (answer) => {
      if (answer.toLowerCase() === 'y' || answer.toLowerCase() === 'yes') {
        await exportUsersToCSV(users);
      }
      rl.close();
      process.exit(0);
    });
    
  } catch (error) {
    console.error('❌ Script failed:', error);
    process.exit(1);
  }
}

// Run the script
if (require.main === module) {
  main();
}

module.exports = { getAllUsers, exportUsersToCSV };


