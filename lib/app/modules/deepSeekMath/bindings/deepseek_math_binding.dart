import 'package:get/get.dart';
import '../controllers/deepseek_math_controller.dart';

class DeepSeekMathBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeepSeekMathController>(
      () => DeepSeekMathController(),
    );
  }
}
