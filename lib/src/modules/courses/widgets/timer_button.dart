import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rs/src/global/utils/colors.dart';
import 'package:rs/src/modules/timer/timer_screen.dart';

class TimerButton extends StatelessWidget {
  const TimerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(TimerScreen());
      },
      child: Container(
        width: 136,
        height: 50,
        decoration: BoxDecoration(
            color: AppColors.textFormFill,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SvgPicture.asset("assets/svg/Vector.svg"),
              const SizedBox(
                width: 25,
              ),
              Text(
                "timer".tr,
                style: Get.theme.textTheme.bodyText2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
