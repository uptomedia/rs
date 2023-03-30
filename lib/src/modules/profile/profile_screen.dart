import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rs/src/global/models/User/user.dart';

import '../../global/utils/colors.dart';
import '../../global/utils/padding.dart';
import '../../global/widgets/background.dart';
import '../../global/widgets/logo.dart';
import 'controllers/register_controller.dart';

class ProfileScreen extends GetView {
  ProfileScreen({super.key});
  @override
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          const Background(),
          GetBuilder(
              init: controller,
              builder: (controller) => FutureBuilder(
                    future: controller.getUser(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        User data = snapshot.data!;
                        return SingleChildScrollView(
                          child: Padding(
                            padding: AppPading.defaultPadding,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Center(child: Logo()),
                                Padding(
                                  padding: AppPading.defaultPadding,
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        TextFormField(
                                          controller: controller.name,
                                          decoration: InputDecoration(
                                              prefixIcon: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: SvgPicture.asset(
                                                  'assets/svg/Vector (1).svg',
                                                  width: 10,
                                                  height: 10,
                                                ),
                                              ),
                                              label: Text(
                                                "username".tr,
                                                style: Get
                                                    .theme.textTheme.bodyText1,
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
                                                style: Get
                                                    .theme.textTheme.bodyText1,
                                              )),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        TextFormField(
                                          controller: controller.password,
                                          // obscureText: true,
                                          decoration: InputDecoration(
                                              prefixIcon: const Icon(Icons.lock,
                                                  color: AppColors.primary,
                                                  size: 30),
                                              label: Text(
                                                "password".tr,
                                                style: Get
                                                    .theme.textTheme.bodyText1,
                                              )),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        SizedBox(
                                          width: 250,
                                          height: 58,
                                          child: TextButton(
                                            onPressed: () {
                                              controller.sendLoginReq();
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                "save".tr,
                                                style: Get
                                                    .theme.textTheme.bodyText2,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                      if (snapshot.hasError) {
                        print(snapshot.error);
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  )),
        ],
      )),
    );
  }
}
