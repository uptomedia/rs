import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rs/src/global/controllers/app.dart';
import 'package:rs/src/global/controllers/auth.dart';
import 'package:rs/src/global/utils/padding.dart';
import 'package:rs/src/global/widgets/app_bar.dart';
import 'package:rs/src/global/widgets/background.dart';
import 'package:rs/src/global/widgets/social_row.dart';
import 'package:rs/src/modules/profile/profile_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../global/utils/colors.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  final AppController appController = Get.find<AppController>();
  final AuthController authController = Get.find<AuthController>();
  final AdSize adSize = const AdSize(width: 300, height: 50);
  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-5236252671718127/7923011414',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );

  Future<void> loadbanner() async {
    await myBanner.load();

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Stack(
        children: [
          const Background(),
          Padding(
            padding: AppPading.defaultPadding,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset("assets/svg/settings2.svg"),
                          const SizedBox(
                            width: 20,
                          ),
                          Text("settings".tr)
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      GestureDetector(
                        onTap: () {
                          appController.showLangDialog();
                          // Get.to(const TimerScreen());
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
                                SvgPicture.asset("assets/svg/lang.svg"),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  "lang".tr,
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
                        onTap: () async {
                          final Uri _url = Uri.parse(
                              'https://programmingwithrs.com/about-us');
                          if (!await launchUrl(_url)) {
                            throw Exception('Could not launch $_url');
                          }
                          // Get.to(CalculatorScreen());
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
                                SvgPicture.asset("assets/svg/ask.svg"),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  "about".tr,
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
                          Get.to(ProfileScreen());
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
                                SvgPicture.asset("assets/svg/person.svg"),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  "account".tr,
                                  style: Get.theme.textTheme.bodyText2,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          authController.logOut();
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
                                Icon(Icons.logout),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  "logOut".tr,
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
                    ],
                  ),
                ),
                SocialRow()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
