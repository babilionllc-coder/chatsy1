import 'dart:convert';
import 'package:http/http.dart' as http;
import '../helper/constants.dart';

class FirebaseAPIService {
  static const String _baseUrl = Constants.baseUrl;
  
  // Headers for API requests
  static Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // User Authentication
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(Constants.loginUrl),
        headers: _headers,
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'status': false,
          'message': 'Login failed: ${response.statusCode}',
          'data': null,
        };
      }
    } catch (e) {
      return {
        'status': false,
        'message': 'Login error: $e',
        'data': null,
      };
    }
  }

  static Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(Constants.registerUrl),
        headers: _headers,
        body: jsonEncode({
          'email': email,
          'password': password,
          'name': name,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'status': false,
          'message': 'Registration failed: ${response.statusCode}',
          'data': null,
        };
      }
    } catch (e) {
      return {
        'status': false,
        'message': 'Registration error: $e',
        'data': null,
      };
    }
  }

  // Chat Management
  static Future<Map<String, dynamic>> sendMessage({
    required String userId,
    required String message,
    String modelType = 'gpt-4',
  }) async {
    try {
      final response = await http.post(
        Uri.parse(Constants.sendMessageUrl),
        headers: _headers,
        body: jsonEncode({
          'userId': userId,
          'message': message,
          'modelType': modelType,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'status': false,
          'message': 'Send message failed: ${response.statusCode}',
          'data': null,
        };
      }
    } catch (e) {
      return {
        'status': false,
        'message': 'Send message error: $e',
        'data': null,
      };
    }
  }

  static Future<Map<String, dynamic>> getChatHistory({
    required String userId,
    int limit = 50,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.chatHistoryUrl}?userId=$userId&limit=$limit'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'status': false,
          'message': 'Get chat history failed: ${response.statusCode}',
          'data': null,
        };
      }
    } catch (e) {
      return {
        'status': false,
        'message': 'Get chat history error: $e',
        'data': null,
      };
    }
  }

  // Admin Functions
  static Future<Map<String, dynamic>> getAllUsers() async {
    try {
      final response = await http.get(
        Uri.parse(Constants.getAllUsersUrl),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'status': false,
          'message': 'Get all users failed: ${response.statusCode}',
          'data': null,
        };
      }
    } catch (e) {
      return {
        'status': false,
        'message': 'Get all users error: $e',
        'data': null,
      };
    }
  }

  // Health Check
  static Future<Map<String, dynamic>> healthCheck() async {
    try {
      final response = await http.get(
        Uri.parse(Constants.healthUrl),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'status': false,
          'message': 'Health check failed: ${response.statusCode}',
          'data': null,
        };
      }
    } catch (e) {
      return {
        'status': false,
        'message': 'Health check error: $e',
        'data': null,
      };
    }
  }
}

