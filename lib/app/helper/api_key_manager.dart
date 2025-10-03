import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Secure API Key Manager for Chatsy App
/// This class manages API keys securely using Flutter Secure Storage
class ApiKeyManager {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  // API Key Storage Keys
  static const String _openaiKey = 'openai_api_key';
  static const String _geminiKey = 'gemini_api_key';
  static const String _elevenlabsKey = 'elevenlabs_api_key';
  static const String _deepseekKey = 'deepseek_api_key';
  static const String _tavilyKey = 'tavily_api_key';
  static const String _youtubeKey = 'youtube_api_key';
  static const String _weatherKey = 'weather_api_key';
  static const String _backendKey = 'backend_api_key';
  static const String _elevenlabsVoiceId = 'elevenlabs_voice_id';

  // Default API Keys (fallback)
  static const Map<String, String> _defaultKeys = {
    _openaiKey: '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',
    _geminiKey: 'AIzaSyBrhiLYE-Ky0M4TUxYOAAkC-54uod6SUq8',
    _elevenlabsKey: 'd6076164757ffbf89920afab7bb9d720cced1bc5f960012eabb3ac89d5c61d0b',
    _deepseekKey: 'sk-77230566a72d45118659609bfa390389',
    _tavilyKey: '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',
    _youtubeKey: 'AIzaSyDgQE9OiM4OQ7NcfqOJgP90wQYqY2BXxn8',
    _weatherKey: 'a1ff45eee21e4d39ca0762bc6241ac38',
    _backendKey: 'YOUR_BACKEND_API_KEY_HERE',
    _elevenlabsVoiceId: 'YOUR_ELEVENLABS_VOICE_ID_HERE',
  };

  /// Initialize API keys - loads from secure storage or uses defaults
  static Future<void> initialize() async {
    try {
      // Check if keys are already stored
      final storedKeys = await _getAllStoredKeys();
      
      // If no keys are stored, save the default keys
      if (storedKeys.isEmpty) {
        await _saveDefaultKeys();
        if (kDebugMode) {
          print('🔐 ApiKeyManager: Default API keys saved to secure storage');
        }
      } else {
        if (kDebugMode) {
          print('🔐 ApiKeyManager: API keys loaded from secure storage');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ ApiKeyManager: Error initializing - $e');
      }
    }
  }

  /// Get API key for a specific service
  static Future<String> getApiKey(String service) async {
    try {
      final key = _getStorageKey(service);
      final storedKey = await _storage.read(key: key);
      
      if (storedKey != null && storedKey.isNotEmpty) {
        return storedKey;
      }
      
      // Return default key if not found in storage
      return _defaultKeys[key] ?? 'YOUR_${service.toUpperCase()}_API_KEY_HERE';
    } catch (e) {
      if (kDebugMode) {
        print('❌ ApiKeyManager: Error getting API key for $service - $e');
      }
      return _defaultKeys[_getStorageKey(service)] ?? 'YOUR_${service.toUpperCase()}_API_KEY_HERE';
    }
  }

  /// Set API key for a specific service
  static Future<void> setApiKey(String service, String key) async {
    try {
      final storageKey = _getStorageKey(service);
      await _storage.write(key: storageKey, value: key);
      if (kDebugMode) {
        print('✅ ApiKeyManager: API key updated for $service');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ ApiKeyManager: Error setting API key for $service - $e');
      }
    }
  }

  /// Check if API key is configured (not placeholder)
  static Future<bool> isApiKeyConfigured(String service) async {
    try {
      final key = await getApiKey(service);
      return key.isNotEmpty && 
             !key.startsWith('YOUR_') && 
             !key.endsWith('_HERE') &&
             key != 'your_${service.toLowerCase()}_api_key_here';
    } catch (e) {
      return false;
    }
  }

  /// Get status of all API keys
  static Future<Map<String, bool>> getAllApiKeyStatus() async {
    final status = <String, bool>{};
    
    for (final service in ['openai', 'gemini', 'elevenlabs', 'deepseek', 'tavily', 'youtube', 'weather']) {
      status[service] = await isApiKeyConfigured(service);
    }
    
    return status;
  }

  /// Clear all stored API keys
  static Future<void> clearAllKeys() async {
    try {
      await _storage.deleteAll();
      if (kDebugMode) {
        print('🗑️ ApiKeyManager: All API keys cleared');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ ApiKeyManager: Error clearing API keys - $e');
      }
    }
  }

  /// Get all stored keys (for debugging)
  static Future<Map<String, String>> _getAllStoredKeys() async {
    try {
      return await _storage.readAll();
    } catch (e) {
      return {};
    }
  }

  /// Save default keys to secure storage
  static Future<void> _saveDefaultKeys() async {
    try {
      for (final entry in _defaultKeys.entries) {
        await _storage.write(key: entry.key, value: entry.value);
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ ApiKeyManager: Error saving default keys - $e');
      }
    }
  }

  /// Get storage key for service
  static String _getStorageKey(String service) {
    switch (service.toLowerCase()) {
      case 'openai':
        return _openaiKey;
      case 'gemini':
        return _geminiKey;
      case 'elevenlabs':
        return _elevenlabsKey;
      case 'deepseek':
        return _deepseekKey;
      case 'tavily':
        return _tavilyKey;
      case 'youtube':
        return _youtubeKey;
      case 'weather':
        return _weatherKey;
      case 'backend':
        return _backendKey;
      case 'elevenlabs_voice_id':
        return _elevenlabsVoiceId;
      default:
        return '${service.toLowerCase()}_api_key';
    }
  }

  /// Validate API key format
  static bool validateApiKey(String service, String key) {
    if (key.isEmpty || key.startsWith('YOUR_') || key.endsWith('_HERE')) {
      return false;
    }

    switch (service.toLowerCase()) {
      case 'openai':
        return key.startsWith('sk-') && key.length > 20;
      case 'gemini':
        return key.startsWith('AIza') && key.length > 20;
      case 'elevenlabs':
        return key.length > 20;
      case 'deepseek':
        return key.startsWith('sk-') && key.length > 20;
      case 'tavily':
        return key.startsWith('tvly-') && key.length > 20;
      case 'youtube':
        return key.startsWith('AIza') && key.length > 20;
      case 'weather':
        return key.length > 10;
      default:
        return key.length > 5;
    }
  }
}
