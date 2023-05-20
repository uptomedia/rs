import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rs/src/global/common/loading.dart';
import 'package:rs/src/global/controllers/app.dart';
import 'package:rs/src/global/widgets/background.dart';
import 'package:rs/src/global/widgets/logo.dart';
import 'package:rs/src/modules/home/home_screen.dart';
import 'package:rs/src/modules/signup/signup_view.dart';
import '../../global/utils/colors.dart';
import '../../global/utils/padding.dart';
import 'controllers/login_controller.dart';

class LoginScreen extends GetView {
  LoginScreen({super.key});
  @override
  final LoginController controller = Get.put(LoginController());
  final AppController appcontroller = Get.find<AppController>();
  final LocalKey formKey = const ObjectKey("value");

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
                    Padding(
                      padding: AppPading.defaultPadding,
                      child: Center(
                        child: Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextFormField(
                                controller: controller.email,
                                keyboardType: TextInputType.text,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "username is not valid";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                        'assets/svg/Vector (1).svg',
                                        width: 10,
                                        height: 10,
                                      ),
                                    ),
                                    // const Icon(
                                    //   Icons.person_outline,
                                    //   color: AppColors.primary,
                                    // ),
                                    label: Text(
                                      "username".tr,
                                      style: Get.theme.textTheme.bodyText1,
                                    )),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                controller: controller.password,
                                obscureText: true,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.length < 8) {
                                    return "Password Should be longer than 8 chars";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.lock_outline,
                                        color: AppColors.primary, size: 30),
                                    label: Text(
                                      "password".tr,
                                      style: Get.theme.textTheme.bodyText1,
                                    )),
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                              SizedBox(
                                width: 250,
                                height: 58,
                                child: TextButton(
                                  onPressed: () {
                                    controller.sendLoginReq();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "login".tr,
                                      style: Get.theme.textTheme.bodyText2,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                width: 250,
                                height: 58,
                                child: TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.transparent),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                              side: const BorderSide(
                                                  color: AppColors.text,
                                                  width: 2)))),
                                  onPressed: () {
                                    Get.to(SignUpScreen());
                                    // controller.sendLoginReq();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
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
                                  // Get.to(const ForgetPasswordScreen());
                                },
                                child: Text(
                                  "ForgetPassword".tr,
                                  style:
                                      const TextStyle(color: AppColors.primary),
                                ),
                              )
                            ],
                          ),
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
