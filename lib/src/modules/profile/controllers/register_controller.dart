import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rs/src/global/models/User/user.dart';
import 'package:rs/src/modules/login/login_view.dart';

import '../../../global/controllers/auth.dart';
import '../../../global/models/Auth/register/register_request.dart';

class ProfileController extends GetxController {
  AuthController auth = Get.find<AuthController>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController birthday = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  void sendLoginReq() async {
    SignUpRequest req = SignUpRequest(
        email: email.text,
        password: password.text,
        name: name.text,
        password_confirmation: password.text,
        phone: phone.text,
        birthday: birthday.text);

    await auth.register(req);
  }

  Future<void> getUser() async {
    if (auth.token == null) {
      Get.offAll(LoginScreen());
    } else {
      User us = await auth.getUser();
      name.text = us.name;
      email.text = us.email;
      phone.text = us.phone;
      password.text = auth.tokenBox!.get('password') ?? "";
      update();
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
