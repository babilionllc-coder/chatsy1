import 'package:get/get.dart';
import '../controllers/voice_cloning_controller.dart';

class VoiceCloningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VoiceCloningController>(
      () => VoiceCloningController(),
    );
  }
}


