import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/elevenLabLib/elevenlabs_flutter.dart';
import 'package:chatsy/elevenLabLib/elevenlabs_types.dart';
import 'package:chatsy/app/helper/Global.dart';

class VoiceCloningController extends GetxController {
  // Observable variables
  final isUploading = false.obs;
  final isProcessing = false.obs;
  final isCloning = false.obs;
  final uploadedFiles = <File>[].obs;
  final clonedVoices = <dynamic>[].obs;
  final voiceName = ''.obs;
  final voiceDescription = ''.obs;
  final voiceLabels = ''.obs;
  
  // Voice cloning progress
  final cloningProgress = 0.0.obs;
  final cloningStatus = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadClonedVoices();
  }

  // Pick audio files for voice cloning
  Future<void> pickAudioFiles() async {
    try {
      isUploading.value = true;
      
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
        allowMultiple: true,
        allowedExtensions: ['wav', 'mp3', 'm4a', 'flac'],
      );

      if (result != null) {
        uploadedFiles.clear();
        for (var file in result.files) {
          if (file.path != null) {
            uploadedFiles.add(File(file.path!));
          }
        }
        printAction("📁 Selected ${uploadedFiles.length} audio files for voice cloning");
      }
    } catch (e) {
      printAction("❌ Error picking audio files: $e");
      utils.showSnackBar(context: Get.context!, message: "Error selecting audio files: $e");
    } finally {
      isUploading.value = false;
    }
  }

  // Clone voice using ElevenLabs API
  Future<void> cloneVoice() async {
    if (uploadedFiles.isEmpty || voiceName.value.isEmpty) {
      utils.showSnackBar(context: Get.context!, message: "Please select audio files and enter a voice name");
      return;
    }

    try {
      isCloning.value = true;
      cloningProgress.value = 0.0;
      cloningStatus.value = "Preparing voice cloning...";

      // Initialize ElevenLabs API
      await _initializeElevenLabs();

      // Prepare voice cloning request
      final filePaths = uploadedFiles.map((file) => file.path).toList();
      
      cloningProgress.value = 0.2;
      cloningStatus.value = "Uploading audio samples...";

      final addVoiceRequest = AddVoiceRequest(
        name: voiceName.value,
        description: voiceDescription.value.isNotEmpty ? voiceDescription.value : null,
        labels: voiceLabels.value.isNotEmpty ? voiceLabels.value : null,
        files: filePaths,
      );

      cloningProgress.value = 0.5;
      cloningStatus.value = "Processing voice samples...";

      // Clone the voice
      final voiceId = await ElevenLabsAPI().addVoice(addVoiceRequest);
      
      cloningProgress.value = 0.8;
      cloningStatus.value = "Finalizing voice clone...";

      // Get the cloned voice details
      final clonedVoice = await ElevenLabsAPI().getVoice(voiceId);
      clonedVoices.add(clonedVoice);

      cloningProgress.value = 1.0;
      cloningStatus.value = "Voice cloned successfully!";

      printAction("🎉 Voice cloned successfully! Voice ID: $voiceId");
      utils.showSnackBar(context: Get.context!, message: "Voice cloned successfully!");

      // Reset form
      _resetForm();

    } catch (e) {
      printAction("❌ Error cloning voice: $e");
      utils.showSnackBar(context: Get.context!, message: "Error cloning voice: $e");
      cloningStatus.value = "Voice cloning failed";
    } finally {
      isCloning.value = false;
      Future.delayed(Duration(seconds: 2), () {
        cloningProgress.value = 0.0;
        cloningStatus.value = '';
      });
    }
  }

  // Load existing cloned voices
  Future<void> loadClonedVoices() async {
    try {
      await _initializeElevenLabs();
      final voices = await ElevenLabsAPI().listVoices();
      
      // Filter only cloned voices (voices with custom names)
      clonedVoices.value = voices.where((voice) => 
        voice.name != 'Default Voice' && 
        voice.name.isNotEmpty
      ).toList();
      
      printAction("📋 Loaded ${clonedVoices.length} cloned voices");
    } catch (e) {
      printAction("❌ Error loading cloned voices: $e");
    }
  }

  // Delete cloned voice
  Future<void> deleteClonedVoice(String voiceId) async {
    try {
      await _initializeElevenLabs();
      await ElevenLabsAPI().deleteVoice(voiceId);
      
      clonedVoices.removeWhere((voice) => voice.voiceId == voiceId);
      utils.showSnackBar(context: Get.context!, message: "Voice deleted successfully");
      
      printAction("🗑️ Deleted voice: $voiceId");
    } catch (e) {
      printAction("❌ Error deleting voice: $e");
      utils.showSnackBar(context: Get.context!, message: "Error deleting voice: $e");
    }
  }

  // Test cloned voice
  Future<void> testClonedVoice(String voiceId, String text) async {
    try {
      await _initializeElevenLabs();
      
      final request = TextToSpeechRequest(
        voiceId: voiceId,
        text: text,
        modelId: "eleven_multilingual_v2",
        voiceSettings: VoiceSettings(
          similarityBoost: 0.8,
          stability: 0.75,
        ),
      );

      final audioFile = await ElevenLabsAPI().synthesize(request);
      printAction("🔊 Generated audio file: ${audioFile.path}");
      
      // Play the audio file
      // You can implement audio playback here
      
    } catch (e) {
      printAction("❌ Error testing voice: $e");
      utils.showSnackBar(context: Get.context!, message: "Error testing voice: $e");
    }
  }

  // Initialize ElevenLabs API
  Future<void> _initializeElevenLabs() async {
    try {
      await Global.elevenLabInit();
    } catch (e) {
      throw Exception("Failed to initialize ElevenLabs: $e");
    }
  }

  // Reset form
  void _resetForm() {
    voiceName.value = '';
    voiceDescription.value = '';
    voiceLabels.value = '';
    uploadedFiles.clear();
  }

  // Clear uploaded files
  void clearUploadedFiles() {
    uploadedFiles.clear();
  }

  // Remove specific uploaded file
  void removeUploadedFile(int index) {
    if (index >= 0 && index < uploadedFiles.length) {
      uploadedFiles.removeAt(index);
    }
  }
}
