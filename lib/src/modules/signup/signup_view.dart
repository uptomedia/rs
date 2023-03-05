import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../global/utils/colors.dart';
import '../../global/utils/padding.dart';
import '../../global/widgets/background.dart';
import '../../global/widgets/logo.dart';
import '../login/login_view.dart';
import 'controllers/register_controller.dart';

class SignUpScreen extends GetView {
  SignUpScreen({super.key});
  final RegisterController controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          const Background(),
          GetBuilder(
            init: controller,
            builder: (controller) => SingleChildScrollView(
              child: Padding(
                padding: AppPading.defaultPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(child: Logo()),
                    Text(
                      "greeting".tr,
                      style: Get.theme.textTheme.headline1,
                    ),
                    Text(
                      "login_hint".tr,
                    ),
                    const SizedBox(),
                    Padding(
                      padding: AppPading.defaultPadding,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextFormField(
                              controller: controller.name,
                              decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SvgPicture.asset(
                                      'assets/svg/Vector (1).svg',
                                      width: 10,
                                      height: 10,
                                    ),
                                  ),
                                  label: Text(
                                    "username".tr,
                                    style: Get.theme.textTheme.bodyText1,
                                  )),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: controller.email,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.email_outlined,
                                    color: AppColors.primary,
                                    size: 30,
                                  ),
                                  label: Text(
                                    "email".tr,
                                    style: Get.theme.textTheme.bodyText1,
                                  )),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: controller.password,
                              obscureText: true,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.lock_outlined,
                                      color: AppColors.primary, size: 30),
                                  label: Text(
                                    "password".tr,
                                    style: Get.theme.textTheme.bodyText1,
                                  )),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            SizedBox(
                              width: 250,
                              height: 58,
                              child: TextButton(
                                // style: ButtonStyle(
                                //     backgroundColor:
                                //         MaterialStateProperty.all<Color>(
                                //             Colors.transparent),
                                //     shape: MaterialStateProperty.all<
                                //             RoundedRectangleBorder>(
                                //         RoundedRectangleBorder(
                                //             borderRadius:
                                //                 BorderRadius.circular(25.0),
                                //             side: const BorderSide(
                                //                 color: AppColors.primary,
                                //                 width: 2)))),
                                onPressed: () {
                                  controller.sendLoginReq();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "register".tr,
                                    style: Get.theme.textTheme.bodyText2,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(LoginScreen());
                              },
                              child: Text(
                                "haveAccount".tr,
                                style:
                                    const TextStyle(color: AppColors.primary),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
