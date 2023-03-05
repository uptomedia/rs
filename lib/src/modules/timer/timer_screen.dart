import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rs/src/global/utils/padding.dart';
import 'package:rs/src/global/widgets/background.dart';
import 'package:rs/src/modules/timer/controllers/timer_controller.dart';
import 'package:rs/src/modules/timer/widgets/button.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TimerController controller = Get.find<TimerController>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfff5fbff),
        body: Stack(
          children: [
            const Background(),
            GetBuilder(
              init: controller,
              builder: (controller) {
                return Padding(
                  padding: AppPading.defaultPadding,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset("assets/svg/Vector.svg"),
                          const SizedBox(
                            width: 20,
                          ),
                          Text("timer".tr)
                        ],
                      ),
                      Expanded(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                                width: 250,
                                height: 250,
                                child: DottedBorder(
                                  strokeWidth: 2,
                                  borderType: BorderType.Circle,
                                  dashPattern: [1, 4],
                                  color: Colors.white,
                                  radius: const Radius.circular(100),
                                  child: Container(),
                                )),
                            SizedBox(
                              width: 250,
                              height: 250,
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.transparent,
                                color: const Color(0xffFFB140),
                                value: 1 - controller.progress,
                                strokeWidth: 4,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (controller.controller.isDismissed) {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => Container(
                                      height: 300,
                                      child: CupertinoTimerPicker(
                                        initialTimerDuration:
                                            controller.controller.duration!,
                                        onTimerDurationChanged: (time) {
                                          controller.controller.duration = time;
                                          controller.update();
                                        },
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: AnimatedBuilder(
                                animation: controller,
                                builder: (context, child) => Text(
                                  controller.countText,
                                  style: const TextStyle(
                                    fontSize: 40,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.controller.stop();
                                controller.isPlaying = false;
                                controller.update();
                              },
                              child: const Icon(
                                Icons.pause,
                                size: 36,
                                color: Colors.white,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.controller.reverse(
                                    from: controller.controller.value == 0
                                        ? 1.0
                                        : controller.controller.value);
                                controller.isPlaying = true;
                                controller.update();
                              },
                              child: const RoundButton(
                                icon: Icons.play_arrow,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.controller.reset();

                                controller.isPlaying = false;
                                controller.update();
                              },
                              child: const Icon(
                                Icons.repeat,
                                size: 36,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
