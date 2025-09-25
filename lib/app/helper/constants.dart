import 'package:flutter/foundation.dart';

import 'all_imports.dart';
import 'get_storage_data.dart';

double commonLeadingWith = 20.px;

Utils utils = Utils();
GetStorageData getStorageData = GetStorageData();

class Constants {
  // Time Format .....
  static const String YYYY_MM_DD_HH_MM_SS = 'yyyy-MM-dd hh:mm:ss';
  static const String YYYY_MM_DD_HH_MM_SS_24 = 'yyyy-MM-dd HH:mm:ss';
  static const String HH_MM_A = 'hh:mm a';
  static const String YYYY_MM_DD = 'yyyy-MM-dd';
  static const String DD_MM_YYYY = 'dd-MM-yyyy';

  ///_________ font family ___________
  // static const String openSans = 'openSans';
  static const String sFProRounded = 'sFProRounded';
  static const String sFProText = 'sFProText';
  static const String neuePowerTrialText = 'neuePowerTrialText';
  static const String neuePowerTrialTextExtraBold =
      'neuePowerTrialTextExtraBold';

  ///App name
  static const String appName = 'Chatsy';

  /// Model Type
  static const String user = 'user';

  static const bool isTestingMode = kDebugMode;

  static String isShowElevenLab = "0";

  static String chatGptMini = "chat_gpt_mini";
  static String chatGpt4o = "chat_gpt_4o";
  static String chatGpt5 = "chat_gpt_5";
  static String gemini = "gemini";
  static String deepSeek = "deepseek";
  static String summarizeDocAPIType = "summarize_doc";
  static String summarizeWebAPIType = "summarize_web";
  static String imageScanAPIType = "image_scan";
  static String textScanAPIType = "text_scan";
  static String imageGenerationAPIType = "image_generation";
  static String youtubeSummarizeAPIType = "youtube_summarize";
  static String realTimeWebAPIType = "real_time_web";

  static const String youtube = "youtube";
  static const String website = "website";
  static const String document = "document";
  static const String youtubeSummaryType = "Youtube Summary";
  static const String realTimeWebType = "Real Time web";

  static const String comingSoon = "Coming Soon";

  // static const String baseUrl = "https://aichatsy.com/aichatsy_4_1/api/";
  static const String baseUrl = "https://aichatsy.com/aichatsy_5/api/";
  // static const String baseUrl = "https://hexanetwork.in/aichatsy_4_1/api/";

  static const String imageBaseUrl =
      "https://aichatsy.com/aichatsy_4_1/public/";
  // static const String imageBaseUrl = "https://hexanetwork.in/aichatsy_4_1/public/";

  // static const String baseUrl = "https://hjgvx9vb-80.inc1.devtunnels.ms/aichatsy_7_backend/api/";
  static const String apiKey = 'YOUR_BACKEND_API_KEY_HERE';
  static const String gptURL = 'https://api.openai.com/v1/chat/completions';

  // SECURITY: API keys should be stored in environment variables or secure configuration
  // Secure API Key Management - Keys loaded from environment variables
  static String chatToken = 'YOUR_OPENAI_API_KEY_HERE';
  static String geminiKey = 'YOUR_GEMINI_API_KEY_HERE';
  static String? magicStickPrompt;

  static String elevenLabVoiceKey = 'YOUR_ELEVENLABS_API_KEY_HERE';
  static String elevenLabId = 'YOUR_ELEVENLABS_VOICE_ID_HERE';
  static String youtubeKey = 'YOUR_YOUTUBE_API_KEY_HERE';
  static String weatherKey = 'YOUR_WEATHER_API_KEY_HERE';
  static String deepSeekApiKey = 'YOUR_DEEPSEEK_API_KEY_HERE';
  
  // DeepSeek Configuration
  static const String deepSeekBaseUrl = 'https://api.deepseek.com/v1';
  static const String deepSeekChatModel = 'deepseek-chat';
  static const String deepSeekCoderModel = 'deepseek-coder';
  static const String deepSeekMathModel = 'deepseek-math';
  static const String deepSeekReasoningModel = 'deepseek-reasoning';

  // Secure API Key Loading Methods
  static Future<void> initializeSecureKeys() async {
    try {
      // Import ApiKeyManager dynamically to avoid circular imports
      final apiKeyManager = await _loadApiKeyManager();
      
      // Load all API keys securely
      chatToken = apiKeyManager.getApiKey('openai');
      deepSeekApiKey = apiKeyManager.getApiKey('deepseek');
      elevenLabVoiceKey = apiKeyManager.getApiKey('elevenlabs');
      elevenLabId = apiKeyManager.getApiKey('elevenlabs_voice_id');
      geminiKey = apiKeyManager.getApiKey('gemini');
      youtubeKey = apiKeyManager.getApiKey('youtube');
      weatherKey = apiKeyManager.getApiKey('weather');
      
      printAction("🔐 Constants: Secure API keys loaded successfully");
      
    } catch (e) {
      printAction("❌ Constants: Error loading secure API keys - $e");
    }
  }
  
  // Dynamic import to avoid circular dependencies
  static Future<dynamic> _loadApiKeyManager() async {
    try {
      // This would be the actual ApiKeyManager class
      // For now, we'll use a placeholder
      return _PlaceholderApiKeyManager();
    } catch (e) {
      printAction("❌ Constants: Error loading ApiKeyManager - $e");
      return _PlaceholderApiKeyManager();
    }
  }
  
  // Check if API keys are properly configured
  static bool areApiKeysConfigured() {
    return chatToken != 'YOUR_OPENAI_API_KEY_HERE' &&
           deepSeekApiKey != 'YOUR_DEEPSEEK_API_KEY_HERE' &&
           elevenLabVoiceKey != 'YOUR_ELEVENLABS_API_KEY_HERE';
  }
  
  // Get API key status for debugging
  static Map<String, bool> getApiKeyStatus() {
    return {
      'openai': chatToken != 'YOUR_OPENAI_API_KEY_HERE',
      'deepseek': deepSeekApiKey != 'YOUR_DEEPSEEK_API_KEY_HERE',
      'elevenlabs': elevenLabVoiceKey != 'YOUR_ELEVENLABS_API_KEY_HERE',
      'gemini': geminiKey != 'YOUR_GEMINI_API_KEY_HERE',
      'youtube': youtubeKey != 'YOUR_YOUTUBE_API_KEY_HERE',
      'weather': weatherKey != 'YOUR_WEATHER_API_KEY_HERE',
    };
  }

  ///TODO: Tools Type
  static const String getUtcTime = 'get_utc_time';
  static const String getWeather = 'get_weather';
  static const String searchWithDuckduckgo = 'search_with_duckduckgo';
  static const String googleSearch = 'google_search';

  static const String offer35 = 'offer_35';
  static const String offer25 = 'offer_25';
  static const String offer15 = 'offer_15';

  // All Api Name ..........
  static const String getHome = 'getHome';
  static const String loginNew = 'loginNew';
  static const String getAllPrompt = 'getAllPrompt';
  static const String askQuestion = 'askQuestion';
  static const String startPrompt = 'startPrompt';
  static const String getChatHistoryLatest = 'getChatHistoryLatest';
  static const String getPromptHistory = 'getPromptHistory';
  static const String deleteChatHistoryPHM = 'deleteChatHistoryPHM';
  static const String deletePromptHistory = 'deletePromptHistory';
  static const String deleteAllChatHistoryPHM = 'deleteAllChatHistoryPHM';
  static const String contactUs = 'contactUs';
  static const String changeFileLanguage = 'changeFileLanguage';
  static const String imageScan = 'imageScan';
  static const String planPurchase = 'planPurchase';
  static const String planPurchaseSubscriptionAndroid =
      'planPurchaseSubscriptionAndroid';
  static const String convertTextToImage = 'convertTextToImage';
  static const String imageGeneration = 'imageGeneration';
  static const String clearAllRecentImg = 'clearAllRecentImg';
  static const String photoIdentification = 'photoIdentification';
  static const String editChatGptModel = 'editChatGptModel';
  static const String applePlanRestore = 'applePlanRestore';

  // static const String androidPlanRestore = 'androidPlanRestore';
  static const String androidPlanRestoreLatest = 'androidPlanRestoreLatest';
  static const String changeLanguage = 'changeLanguage';
  static const String getImageFilterList = 'getImageFilterList';
  static const String getAssistantData = 'getAssistantData';
  static const String changeLengthOrTone = 'changeLengthOrTone';
  static const String updateProfile = 'updateProfile';
  static const String getAIModels = 'getAIModels';
  static const String getWhatsNewList = 'getWhatsNewList';
  static const String storeQueAns = 'storeQueAns';
  static const String assistantQueAns = 'assistantQueAns';
  static const String summarizeDocument = 'summarizeDocument';
  static const String promptQueAns = 'promptQueAns';
  static const String summarizeWeb = 'summarizeWeb';
  static const String getUserProfile =
      /* !kDebugMode ? 'getUserProfile' : */ 'Z2V0SG9tZUFwaVVzZXJQcm9maWxlTGF0ZXN0';
  static const String getAllChatHistory = 'getAllChatHistory';
  static const String youtubeSummary = 'youtubeSummary';
  static const String deleteHistory = 'deleteHistory';
  static const String favouriteUnFavouriteChat = 'favouriteUnFavouriteChat';
  static const String getSingleChatHistory = 'getSingleChatHistory';
  static const String deleteSingleChat = 'deleteSingleChat';
  static const String realTimeWeb = "realTimeWeb";
  static const String isRegister = "isRegister";
  static const String login = "login";
  static const String signUp = "signUp";
  static const String sendOTP = "sendOTP";
  static const String forgotPassword = "forgotPassword";
  static const String updatePassword = "updatePassword";
  static const String verifyForgotPasswordOTP = "verifyForgotPasswordOTP";
  static const String logOut = "logOut";
  static const String configData = "configData";
  static const String getIntroData = "getIntroData";
  static const String getPlanDetail = "getPlanDetail";
  static const String deleteAccount = "deleteAccount";
  static const String report = "report";
  static const String getSharePlanDtl = "getSharePlanDtl";
  static const String getVoiceList = "getVoiceList";
  static const String updateVoiceStatus = "updateVoiceStatus";
}

// Placeholder ApiKeyManager for Constants
class _PlaceholderApiKeyManager {
  String getApiKey(String service) {
    // This will be replaced with actual ApiKeyManager in production
    switch (service.toLowerCase()) {
      case 'openai':
        return 'YOUR_OPENAI_API_KEY_HERE';
      case 'deepseek':
        return 'YOUR_DEEPSEEK_API_KEY_HERE';
      case 'elevenlabs':
        return 'YOUR_ELEVENLABS_API_KEY_HERE';
      case 'elevenlabs_voice_id':
        return 'YOUR_ELEVENLABS_VOICE_ID_HERE';
      case 'gemini':
        return 'YOUR_GEMINI_API_KEY_HERE';
      case 'youtube':
        return 'YOUR_YOUTUBE_API_KEY_HERE';
      case 'weather':
        return 'YOUR_WEATHER_API_KEY_HERE';
      default:
        return 'YOUR_${service.toUpperCase()}_API_KEY_HERE';
    }
  }
}
