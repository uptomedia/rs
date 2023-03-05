import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class TimerController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController controller;

  bool isPlaying = false;

  String get countText {
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed
        ? '${controller.duration!.inHours}:${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  double progress = 1.0;

  void notify() async {
    if (countText == '0:00:00') {
      final player = AudioPlayer();
      await player.setAsset(// Load a URL
          'assets/imgs/tone.mp3');
      player.play();

      // FlutterRingtonePlayer.playNotification(asAlarm: true);
    }
  }

  TimerController() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    );

    controller.addListener(() {
      notify();
      if (controller.isAnimating) {
        progress = controller.value;
        update();
      } else {
        progress = 1.0;
        isPlaying = false;
        update();
      }
    });
  }
}

class TimerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TimerController>(TimerController());
  }
}
