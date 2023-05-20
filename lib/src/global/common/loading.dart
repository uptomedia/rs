import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rs/src/global/controllers/app.dart';
import 'package:rs/src/global/widgets/background.dart';

enum LoadingState { loading, fail, done }

class LoadingUI extends GetView<AppController> {
  LoadingUI({
    super.key,
  });
  @override
  AppController get controller => Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: const [
        Background(),
        Center(
          child: CircularProgressIndicator(),
        ),
      ],
    ));
  }
}
