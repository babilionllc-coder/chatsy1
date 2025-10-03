import 'package:get/get.dart';
import '../controllers/deepseek_coder_controller.dart';

class DeepSeekCoderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeepSeekCoderController>(
      () => DeepSeekCoderController(),
    );
  }
}
