// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:

import 'package:get/get.dart';
import 'package:rs/src/global/controllers/auth.dart';
import 'package:rs/src/global/widgets/background.dart';
import 'package:rs/src/modules/home/home_screen.dart';
import 'package:rs/src/modules/login/login_view.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late Animation animation;
  late AnimationController controller;
  AuthController auth = Get.find<AuthController>();
  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animation = Tween(begin: 100.0, end: 600.0).animate(controller);
    controller.forward();

    Route route;

    Future.delayed(const Duration(seconds: 3), () {
      Get.offAll(HomeScreen());
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            const Positioned.fill(child: Background()),
            Align(
              alignment: Alignment.center,
              child: Container(
                // height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AnimatedBuilder(
                      animation: animation,
                      builder: (context, child) {
                        return Container(
                          height: animation.value,
                          width: animation.value,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image:
                                  ExactAssetImage("assets/imgs/ramizLogo.png"),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: 80.0, left: 40, right: 40),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: const LinearProgressIndicator(
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
