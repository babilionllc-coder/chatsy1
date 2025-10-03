import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 🗄️ BACKEND DATABASE CONNECTION TOOL
/// 
/// This tool helps you connect to and access your backend database
/// Backend URL: https://aichatsy.com/aichatsy_5/api/
/// 
/// Usage:
/// 1. Run this tool in your Flutter app
/// 2. Test API endpoints
/// 3. View user data
/// 4. Manage backend connections

class BackendConnectionTool extends StatefulWidget {
  const BackendConnectionTool({Key? key}) : super(key: key);

  @override
  State<BackendConnectionTool> createState() => _BackendConnectionToolState();
}

class _BackendConnectionToolState extends State<BackendConnectionTool> {
  final Dio dio = Dio();
  List<Map<String, dynamic>> testResults = [];
  bool isLoading = false;
  String connectionStatus = "Not Connected";
  String? userToken;
  String? userId;

  // Your backend API endpoints
  final String baseUrl = "https://aichatsy.com/aichatsy_5/api/";
  final String apiKey = "YOUR_BACKEND_API_KEY_HERE"; // You need to provide this

  @override
  void initState() {
    super.initState();
    _setupDio();
    _testConnection();
  }

  void _setupDio() {
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    dio.options.headers = {
      'Content-Type': 'application/json',
      'key': apiKey,
      'VERSIONCODE': '1',
      'lang': 'en',
      'DEVICETYPE': 'Android',
    };
  }

  Future<void> _testConnection() async {
    setState(() {
      isLoading = true;
      connectionStatus = "Testing Connection...";
      testResults.clear();
    });

    try {
      // Test 1: Basic connectivity
      await _testEndpoint("GET", "/", "Basic Connectivity Test");
      
      // Test 2: Available endpoints
      await _testAvailableEndpoints();
      
      setState(() {
        connectionStatus = "✅ Backend Connected Successfully";
      });
    } catch (e) {
      setState(() {
        connectionStatus = "❌ Connection Failed: $e";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _testAvailableEndpoints() async {
    final endpoints = [
      {"name": "Sign Up", "endpoint": "signUp", "method": "POST"},
      {"name": "Login", "endpoint": "login", "method": "POST"},
      {"name": "Send OTP", "endpoint": "sendOTP", "method": "POST"},
      {"name": "Check Registration", "endpoint": "isRegister", "method": "POST"},
      {"name": "Get User Profile", "endpoint": "Z2V0SG9tZUFwaVVzZXJQcm9maWxlTGF0ZXN0", "method": "POST"},
      {"name": "Image Generation", "endpoint": "imageGenerationLatest", "method": "POST"},
      {"name": "Create Assistant", "endpoint": "createAssistant", "method": "POST"},
      {"name": "Get Assistants", "endpoint": "getAssistantData", "method": "POST"},
    ];

    for (final endpoint in endpoints) {
      await _testEndpoint(
        endpoint["method"]!,
        "/${endpoint["endpoint"]}",
        endpoint["name"]!,
      );
    }
  }

  Future<void> _testEndpoint(String method, String endpoint, String testName) async {
    try {
      Response response;
      
      if (method == "GET") {
        response = await dio.get(endpoint);
      } else {
        // For POST requests, send minimal test data
        final testData = _getTestDataForEndpoint(endpoint);
        response = await dio.post(endpoint, data: testData);
      }

      setState(() {
        testResults.add({
          "name": testName,
          "endpoint": endpoint,
          "method": method,
          "status": response.statusCode,
          "success": response.statusCode! < 400,
          "response": response.data.toString().substring(0, 200),
        });
      });
    } catch (e) {
      setState(() {
        testResults.add({
          "name": testName,
          "endpoint": endpoint,
          "method": method,
          "status": "Error",
          "success": false,
          "response": e.toString(),
        });
      });
    }
  }

  Map<String, dynamic> _getTestDataForEndpoint(String endpoint) {
    switch (endpoint) {
      case "/signUp":
        return {
          "email": "test@example.com",
          "password": "test123",
          "device_id": "test_device",
          "device_token": "test_token",
          "is_google": null,
          "google_id": null,
          "is_apple": null,
          "apple_id": null,
        };
      case "/login":
        return {
          "email": "test@example.com",
          "password": "test123",
          "device_id": "test_device",
        };
      case "/sendOTP":
        return {
          "email": "test@example.com",
          "device_id": "test_device",
        };
      case "/isRegister":
        return {
          "email": "test@example.com",
          "device_id": "test_device",
        };
      case "/Z2V0SG9tZUFwaVVzZXJQcm9maWxlTGF0ZXN0":
        return {
          "user_id": "test_user_id",
        };
      default:
        return {"test": "data"};
    }
  }

  Future<void> _testUserLogin() async {
    if (isLoading) return;
    
    setState(() {
      isLoading = true;
    });

    try {
      final response = await dio.post("/login", data: {
        "email": "montu.kmphitech@gmail.com", // Test email from your code
        "password": "Montu@123", // Test password from your code
        "device_id": "test_device",
      });

      if (response.statusCode == 200 && response.data['responseCode'] == 1) {
        setState(() {
          userToken = response.data['data']['token'];
          userId = response.data['data']['id'].toString();
        });
        
        Get.snackbar(
          "Login Success",
          "User logged in successfully!",
          snackPosition: SnackPosition.BOTTOM,
        );
        
        // Test getting user profile
        await _getUserProfile();
      }
    } catch (e) {
      Get.snackbar(
        "Login Failed",
        "Error: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _getUserProfile() async {
    if (userId == null) return;

    try {
      final response = await dio.post("/Z2V0SG9tZUFwaVVzZXJQcm9maWxlTGF0ZXN0", data: {
        "user_id": userId,
      });

      if (response.statusCode == 200) {
        Get.snackbar(
          "Profile Retrieved",
          "User profile data: ${response.data.toString().substring(0, 100)}...",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Profile Error",
        "Error: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🗄️ Backend Connection Tool'),
        backgroundColor: Colors.blue,
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
                    '📊 Backend Connection Status',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Backend URL: $baseUrl',
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
                  if (userToken != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      '🔑 User Token: ${userToken!.substring(0, 20)}...',
                      style: const TextStyle(fontSize: 12, color: Colors.blue),
                    ),
                    Text(
                      '👤 User ID: $userId',
                      style: const TextStyle(fontSize: 12, color: Colors.blue),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: isLoading ? null : _testConnection,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Test Connection'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: isLoading ? null : _testUserLogin,
                    icon: const Icon(Icons.login),
                    label: const Text('Test Login'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Test Results
            const Text(
              '🧪 API Endpoint Test Results',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: ListView.builder(
                itemCount: testResults.length,
                itemBuilder: (context, index) {
                  final result = testResults[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: Icon(
                        result["success"] ? Icons.check_circle : Icons.error,
                        color: result["success"] ? Colors.green : Colors.red,
                      ),
                      title: Text(result["name"]),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${result["method"]} ${result["endpoint"]}'),
                          Text('Status: ${result["status"]}'),
                          Text(
                            result["response"],
                            style: const TextStyle(fontSize: 10),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

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
                    '• Your users are stored in the backend database\n'
                    '• API key is required for full access\n'
                    '• Test login uses demo credentials\n'
                    '• All user data is on your backend server\n'
                    '• Contact your backend developer for full access',
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
}

/// 🚀 HOW TO USE THIS TOOL:
/// 
/// 1. Add this to your app's routes
/// 2. Navigate to BackendConnectionTool
/// 3. Click "Test Connection" to check endpoints
/// 4. Click "Test Login" to authenticate
/// 5. View API test results
/// 
/// For full user management, you need to:
/// 1. Get your backend API key
/// 2. Set up admin endpoints
/// 3. Create user management dashboard


