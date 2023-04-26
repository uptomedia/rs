// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:rs/src/modules/home/home_screen.dart';
import 'package:rs/src/modules/login/login_view.dart';

import '../models/Auth/login/login_request.dart';
import '../models/Auth/login/login_response.dart';
import '../models/Auth/register/register_request.dart';
import '../models/User/user.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  Box? tokenBox;
  User? user;
  String? token;
  AuthService service = AuthService();

  AuthController() {
    init();
  }

  Future<void> init() async {
    tokenBox = await Hive.openBox("token");
    token = tokenBox!.get('token');
    if (token != null) {
      await refreshToken();
      // Get.offAll(HomeScreen());
    }
    update();
  }

  Future<void> refreshToken() async {
    // token = await service.refresh(token!);
    print(tokenBox!.get("email"));
    print(tokenBox!.get("password"));
    await login(LoginReq(
        email: tokenBox!.get("email"), password: tokenBox!.get("password")));
    update();
    return;
  }

  Future<void> login(LoginReq req) async {
    Get.bottomSheet(WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Column(
        children: const [Text("Please Wait"), CircularProgressIndicator()],
      ),
    ));
    LoginResponse response = await service.login(req);
    Get.back();
    // print(response.message);
    if (response.message != null) {
      if (response.status == 401) {
        print(response.user.id);
        // Get.to(OtpScreen(response.user));
      }
      Get.snackbar("Error", response.message!);
    } else {
      user = response.user;
      token = response.token;
      tokenBox!.put("token", token);
      tokenBox!.put("email", req.email);
      tokenBox!.put("password", req.password);
      print(token);
      update();
      Get.offAll(HomeScreen());
    }
  }

  Future<void> register(SignUpRequest req) async {
    Get.bottomSheet(WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Column(
        children: const [Text("Please Wait"), CircularProgressIndicator()],
      ),
    ));
    LoginResponse response = await service.register(req);
    Get.back();
    // print(response.message);
    if (response.message != null) {
      if (response.status == 200) {
        Get.snackbar("Success",
            "Confirmation emaile sent to ${req.email} please confirm then login");
        Get.offAll(LoginScreen());
      }
      Get.snackbar("", response.message!);
    } else {
      user = response.user;
      token = response.token;
      tokenBox!.put("token", token);
      print(token);
      update();
      // Get.to(HomeScreen());
    }
  }

  Future<void> logOut() async {
    user = User.empty();
    token = null;
    tokenBox!.clear();
    print(token);
    update();
    Get.to(HomeScreen());
    return;
  }

  Future<User> getUser() async {
    if (token == null) {
      Get.to(LoginScreen());
      return User.empty();
    }
    User response = await service.getUser(token!);
    print(response.toString());
    return response;
  }
}

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
  }
}
