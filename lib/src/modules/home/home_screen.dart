import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rs/src/global/utils/colors.dart';
import 'package:rs/src/global/utils/padding.dart';
import 'package:rs/src/global/widgets/app_bar.dart';
import 'package:rs/src/global/widgets/background.dart';
import 'package:rs/src/global/widgets/social_row.dart';
import 'package:rs/src/modules/calculator/calculator_screen.dart';
import 'package:rs/src/modules/courses/courses_screen.dart';
import 'package:rs/src/modules/settings/settings_screen.dart';
import 'package:rs/src/modules/timer/timer_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final AdSize adSize = const AdSize(width: 300, height: 50);
  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );

  Future<void> loadbanner() async {
    await myBanner.load();
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);

    return;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(),
        body: Stack(children: [
          const Background(),
          SingleChildScrollView(
              child: Padding(
            padding: AppPading.defaultPadding,
            child: SizedBox(
              width: Get.size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(const CoursesScreen());
                    },
                    child: Container(
                      padding: AppPading.defaultPadding,
                      height: 283,
                      width: 322,
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        children: [
                          FittedBox(
                            child: Text(
                              "eduCources".tr,
                              style: Get.theme.textTheme.headline1,
                            ),
                          ),
                          SvgPicture.asset(
                              "assets/svg/E-learning_on_phone.svg"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(const TimerScreen());
                    },
                    child: Container(
                      height: 85,
                      width: 322,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: AppColors.textFormFill),
                      child: Padding(
                        padding: AppPading.defaultPadding,
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
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(CalculatorScreen());
                    },
                    child: Container(
                      height: 85,
                      width: 322,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: AppColors.textFormFill),
                      child: Padding(
                        padding: AppPading.defaultPadding,
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/svg/7-calculator.svg"),
                            const SizedBox(
                              width: 25,
                            ),
                            Text(
                              "calc".tr,
                              style: Get.theme.textTheme.bodyText2,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(SettingScreen());
                    },
                    child: Container(
                      height: 85,
                      width: 322,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: AppColors.textFormFill),
                      child: Padding(
                        padding: AppPading.defaultPadding,
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/svg/Слой_2.svg"),
                            const SizedBox(
                              width: 25,
                            ),
                            Text(
                              "settings".tr,
                              style: Get.theme.textTheme.bodyText2,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: loadbanner(),
                    builder: (context, snapshot) {
                      final AdWidget adWidget = AdWidget(ad: myBanner);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: adWidget,
                          width: myBanner.size.width.toDouble(),
                          height: myBanner.size.height.toDouble(),
                        ),
                      );

                      // return Container();
                    },
                  ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  SocialRow()
                ],
              ),
            ),
          ))
        ]),
      ),
    );
  }
}
