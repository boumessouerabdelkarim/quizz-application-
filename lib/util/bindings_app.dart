import 'package:get/get.dart';
import 'package:quizz_app/controllers/quiz_controller.dart';

class BilndingsApp implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuizController());
  }
}
