
import 'package:get/get.dart';
import 'package:vivatech/repository/auth_repository/auth_repository.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  void registerUser(String email, String password) {
    AuthRepository.instance.createUserWithEmailAndPassword(email, password);
  }

  void loginUser(String email, String password) {
    AuthRepository.instance.loginWithEmailAndPassword(email, password);
  }
}
