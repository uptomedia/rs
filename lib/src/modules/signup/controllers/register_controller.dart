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
      Future.delayed(Duration.zero, () {
        Get.bottomSheet(WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Column(
            children: const [Text("Please Wait"), CircularProgressIndicator()],
          ),
        ));
      });
      SignUpRequest req = SignUpRequest(
          email: email.text,
          password: password.text,
          name: name.text,
          password_confirmation: password.text,
          phone: phone.text,
          birthday: birthday.text);

      await auth.register(req);
      Get.back();
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
