import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global/controllers/auth.dart';
import '../../../global/models/Auth/register/register_request.dart';

class RegisterController extends GetxController {
  AuthController auth = Get.find<AuthController>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController birthday = TextEditingController();

  void sendLoginReq() async {
    if (GetUtils.isEmail(email.text) && password.text.length >= 8) {
      SignUpRequest req = SignUpRequest(
          email: email.text,
          password: password.text,
          name: name.text,
          password_confirmation: password.text,
          phone: phone.text,
          birthday: birthday.text);

      await auth.register(req);
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    name.dispose();
    phone.dispose();
    passwordConfirm.dispose();
    birthday.dispose();
    super.dispose();
    // auth.dispose();
  }
}
