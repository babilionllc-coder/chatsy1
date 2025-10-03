import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 🔥 FIREBASE ADMIN TOOL FOR CHATSY
/// 
/// This tool helps you connect to and manage your Firebase database
/// Project ID: ai-chatsy-390411
/// 
/// Usage:
/// 1. Run this tool in your Flutter app
/// 2. View all Firebase users
/// 3. Manage user data
/// 4. Export user information

class FirebaseAdminTool extends StatefulWidget {
  const FirebaseAdminTool({Key? key}) : super(key: key);

  @override
  State<FirebaseAdminTool> createState() => _FirebaseAdminToolState();
}

class _FirebaseAdminToolState extends State<FirebaseAdminTool> {
  List<User> firebaseUsers = [];
  bool isLoading = false;
  String connectionStatus = "Not Connected";

  @override
  void initState() {
    super.initState();
    _connectToFirebase();
  }

  /// Connect to Firebase and load users
  Future<void> _connectToFirebase() async {
    setState(() {
      isLoading = true;
      connectionStatus = "Connecting...";
    });

    try {
      // Initialize Firebase if not already initialized
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp();
      }

      setState(() {
        connectionStatus = "✅ Connected to Firebase";
      });

      // Load all users (Note: This requires Firebase Admin SDK)
      await _loadFirebaseUsers();

    } catch (e) {
      setState(() {
        connectionStatus = "❌ Connection Failed: $e";
        isLoading = false;
      });
    }
  }

  /// Load Firebase users (requires admin privileges)
  Future<void> _loadFirebaseUsers() async {
    try {
      // Note: This is a simplified version
      // For full user management, you need Firebase Admin SDK
      final currentUser = FirebaseAuth.instance.currentUser;
      
      setState(() {
        if (currentUser != null) {
          firebaseUsers = [currentUser];
        }
        isLoading = false;
      });

    } catch (e) {
      setState(() {
        connectionStatus = "❌ Error loading users: $e";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🔥 Firebase Admin Tool'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Connection Status
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '📊 Firebase Connection Status',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Project ID: ai-chatsy-390411',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    connectionStatus,
                    style: TextStyle(
                      fontSize: 14,
                      color: connectionStatus.contains('✅') 
                          ? Colors.green 
                          : Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Firebase Console Links
            const Text(
              '🔗 Quick Access Links',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            _buildLinkCard(
              'Firebase Console',
              'https://console.firebase.google.com/project/ai-chatsy-390411',
              'Open Firebase Console',
              Icons.dashboard,
            ),

            _buildLinkCard(
              'Authentication Users',
              'https://console.firebase.google.com/project/ai-chatsy-390411/authentication/users',
              'View All Users',
              Icons.people,
            ),

            _buildLinkCard(
              'Analytics',
              'https://console.firebase.google.com/project/ai-chatsy-390411/analytics',
              'View Analytics',
              Icons.analytics,
            ),

            _buildLinkCard(
              'Crashlytics',
              'https://console.firebase.google.com/project/ai-chatsy-390411/crashlytics',
              'View Crashes',
              Icons.bug_report,
            ),

            const SizedBox(height: 20),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: isLoading ? null : _connectToFirebase,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Refresh Connection'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showUserStats();
                    },
                    icon: const Icon(Icons.stats),
                    label: const Text('User Stats'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Current User Info
            if (firebaseUsers.isNotEmpty) ...[
              const Text(
                '👤 Current Firebase User',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email: ${firebaseUsers.first.email ?? "N/A"}'),
                    Text('UID: ${firebaseUsers.first.uid}'),
                    Text('Provider: ${firebaseUsers.first.providerData.map((p) => p.providerId).join(", ")}'),
                    Text('Created: ${firebaseUsers.first.metadata.creationTime}'),
                    Text('Last Sign In: ${firebaseUsers.first.metadata.lastSignInTime}'),
                    Text('Email Verified: ${firebaseUsers.first.emailVerified}'),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 20),

            // Instructions
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange[200]!),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '📝 Important Notes',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '• Firebase only stores users who signed up with Google/Apple\n'
                    '• Your main user database is on your backend server\n'
                    '• Use the links above to access Firebase Console\n'
                    '• For full user management, you need Firebase Admin SDK\n'
                    '• Backend URL: https://aichatsy.com/aichatsy_5/api/',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkCard(String title, String url, String description, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.open_in_new),
        onTap: () {
          // In a real app, you'd open the URL
          Get.snackbar(
            'Link',
            'Would open: $url',
            snackPosition: SnackPosition.BOTTOM,
          );
        },
      ),
    );
  }

  void _showUserStats() {
    Get.dialog(
      AlertDialog(
        title: const Text('📊 User Statistics'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Firebase Users: ${firebaseUsers.length}'),
            const Text('Total Users: Check Backend Database'),
            const Text('Active Users: Check Analytics'),
            const Text('New Users Today: Check Analytics'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

/// 🚀 HOW TO USE THIS TOOL:
/// 
/// 1. Add this to your app's routes
/// 2. Navigate to FirebaseAdminTool
/// 3. Click the links to open Firebase Console
/// 4. Use Firebase Console to manage users
/// 
/// For full user management, you need to:
/// 1. Set up Firebase Admin SDK on your backend
/// 2. Create admin endpoints
/// 3. Build a proper admin dashboard


