import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rs/src/global/controllers/courses.dart';
import 'package:rs/src/global/models/courses/course.dart';
import 'package:rs/src/global/models/courses/course_details_response.dart';
import 'package:rs/src/global/models/courses/courses_responce.dart';
import 'package:rs/src/global/utils/colors.dart';
import 'package:rs/src/global/utils/padding.dart';
import 'package:rs/src/global/widgets/app_bar.dart';
import 'package:rs/src/global/widgets/background.dart';
import 'package:rs/src/modules/courses/enrolled_course.dart';
import 'package:rs/src/modules/login/login_view.dart';

import '../../global/utils/config.dart';

final TextEditingController cupon = TextEditingController();

class CourseDetailsScreen extends GetView<CourseController> {
  final Course course;
  const CourseDetailsScreen({super.key, required this.course});
  @override
  // TODO: implement controller
  CourseController get controller => Get.find<CourseController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(),
        body: Stack(
          children: [
            const Background(),
            Padding(
              padding: AppPading.defaultPadding,
              child: SizedBox(
                width: Get.size.width,
                child: Column(
                  children: [
                    FutureBuilder(
                      future: controller.getCourseDetails(course.id),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          CourseDetailsResponce data = snapshot.data!;
                          print(data.success);
                          if (data.data == null) {
                            return const Expanded(
                              child: Center(
                                child: Text("No Data"),
                              ),
                            );
                          } else {
                            return Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: Get.size.width,
                                      height: Get.size.width / 2,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: course.image != null
                                                  ? NetworkImage(
                                                      "${AppConfig.baseUrl}/${course.image!}")
                                                  : const AssetImage(
                                                          "assets/imgs/Rectangle 8.png")
                                                      as ImageProvider,
                                              fit: BoxFit.cover),
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                    color: AppColors.primary
                                                        .withOpacity(0.7),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: const Center(
                                                  child: Icon(
                                                      Icons.favorite_border),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Text(
                                      data.data!.title,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "courseDetails".tr,
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      data.data!.description,
                                      style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Center(
                                      // onTap: () {
                                      //   Get.to(const TimerScreen());
                                      // },
                                      child: Container(
                                        height: 65,
                                        width: 322,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(11),
                                            color: AppColors.textFormFill),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                  "assets/svg/Vector.svg"),
                                              const SizedBox(
                                                width: 25,
                                              ),
                                              Text(
                                                "courseDuration".tr +
                                                    data.data!.duration
                                                        .toString(),
                                                style: Get
                                                    .theme.textTheme.bodyText2,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Center(
                                      // onTap: () {
                                      //   Get.to(CalculatorScreen());
                                      // },
                                      child: Container(
                                        height: 65,
                                        width: 322,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(11),
                                            color: AppColors.textFormFill),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                  "assets/svg/classes.svg"),
                                              const SizedBox(
                                                width: 25,
                                              ),
                                              Text(
                                                '${"lessonsCount".tr}${data.data!.lessons.length}',
                                                style: Get
                                                    .theme.textTheme.bodyText2,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Center(
                                      child: GestureDetector(
                                        onTap: () async {
                                          if (controller.auth.token == null) {
                                            Get.to(LoginScreen());
                                          } else {
                                            // Get.to(EnrolledCourseScreen(
                                            //     course: data.data!));
                                            CoursesResponce enroll =
                                                await controller
                                                    .checkEnroll(data.data!.id);
                                            if (!enroll.success) {
                                              Get.dialog(BuyDialog(
                                                onBuy: () async {
                                                  CoursesResponce c =
                                                      await controller
                                                          .buyCourse(
                                                              data.data!.id,
                                                              cupon.text);
                                                  if (c.success) {
                                                    Get.to(EnrolledCourseScreen(
                                                        course: data.data!));
                                                  }
                                                },
                                              ));
                                            } else {
                                              Get.to(EnrolledCourseScreen(
                                                  course: data.data!));
                                            }
                                          }
                                        },
                                        child: Container(
                                          height: 65,
                                          width: 322,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                              color: AppColors.primary),
                                          child: Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: Center(
                                                child: Text("enrollNow".tr),
                                              )),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        } else if (snapshot.hasError) {
                          print(snapshot.error);
                          return Expanded(
                            child: Center(
                              child: Text(snapshot.error!.toString()),
                            ),
                          );
                        } else {
                          return const Expanded(
                              child:
                                  Center(child: CircularProgressIndicator()));
                        }
                      },
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
}

class BuyDialog extends StatelessWidget {
  BuyDialog({Key? key, required this.onBuy}) : super(key: key);
  VoidCallback onBuy;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: Get.size.height / 3,
        width: Get.size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: AppColors.primary),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "الاشتراك في الدورة",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                "الرجاء ادخال الكوبون لتفعيل الاشتراك",
                style: TextStyle(fontWeight: FontWeight.w100),
              ),
              TextFormField(
                controller: cupon,
                decoration: const InputDecoration(
                    fillColor: Color(0xff244CA3),
                    hintText: "كوبون الاشتراك",
                    contentPadding: EdgeInsets.all(10)),
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
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              side: const BorderSide(
                                  color: AppColors.text, width: 2)))),
                  onPressed: onBuy,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "الاشتراك".tr,
                      style: Get.theme.textTheme.bodyText2!.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
