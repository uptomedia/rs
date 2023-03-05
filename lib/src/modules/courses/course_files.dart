import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rs/src/global/controllers/courses.dart';
import 'package:rs/src/global/models/courses/courseDetails.dart';
import 'package:rs/src/global/models/courses/course_details_response.dart';
import 'package:rs/src/global/utils/colors.dart';
import 'package:rs/src/global/utils/config.dart';
import 'package:rs/src/global/utils/padding.dart';
import 'package:rs/src/global/widgets/app_bar.dart';
import 'package:rs/src/global/widgets/background.dart';
import 'package:rs/src/modules/courses/video_player.dart';

class CourseFiles extends GetView<CourseController> {
  const CourseFiles({super.key, required this.course});
  final CourseDetails course;
  @override
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
                            return GetBuilder(
                              init: controller,
                              builder: (controller) {
                                return Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      controller.downloading
                                          ? LinearProgressIndicator(
                                              value: double.parse(
                                                      controller.progress) /
                                                  100,
                                            )
                                          : Container(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            "${course.title} / ${"files".tr}"),
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "chapters".tr,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 16),
                                        ),
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: course.files.length,
                                          itemBuilder: (context, index) {
                                            return Center(
                                                child: ListTile(
                                              onTap: () {
                                                controller.downloadFile(
                                                    "${AppConfig.baseUrl}/${course.files[index].file}",
                                                    course
                                                        .files[index].fileName);
                                                // Get.dialog(WillPopScope(
                                                //   child: Dialog(
                                                //     backgroundColor:
                                                //         AppColors.primary,
                                                //     clipBehavior: Clip.hardEdge,
                                                //     child: SizedBox(
                                                //       height: 200,
                                                //       child: Column(
                                                //         children: [
                                                //           IconButton(
                                                //               onPressed: () {
                                                //                 Get.back();
                                                //               },
                                                //               icon: const Icon(Icons
                                                //                   .close_rounded)),
                                                //           Center(
                                                //             child: Padding(
                                                //                 padding:
                                                //                     const EdgeInsets
                                                //                             .all(
                                                //                         8.0),
                                                //                 child:
                                                //                     GetBuilder(
                                                //                   init:
                                                //                       controller,
                                                //                   builder:
                                                //                       (controller) {
                                                //                     return Column(
                                                //                       mainAxisAlignment:
                                                //                           MainAxisAlignment
                                                //                               .center,
                                                //                       children: <
                                                //                           Widget>[
                                                //                         Text(
                                                //                             '${controller.progress}%'),
                                                //                         controller.isDownloaded
                                                //                             ? const Text(
                                                //                                 'File Downloaded! You can see your file in the application\'s directory',
                                                //                                 textAlign: TextAlign.center,
                                                //                               )
                                                //                             : const Text(
                                                //                                 'Your file is being downloaded',
                                                //                                 textAlign: TextAlign.center,
                                                //                               ),
                                                //                       ],
                                                //                     );
                                                //                   },
                                                //                 )),
                                                //           ),
                                                //         ],
                                                //       ),
                                                //     ),
                                                //   ),
                                                //   onWillPop: () async => false,
                                                // ));
                                              },
                                              title: Text(
                                                  course.files[index].fileName),
                                              leading: Container(
                                                  width: 5,
                                                  color:
                                                      AppColors.textFormFill),
                                              trailing: Container(
                                                height: 44,
                                                width: 44,
                                                decoration: BoxDecoration(
                                                    color: AppColors.primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Center(
                                                    child: SvgPicture.asset(
                                                        "assets/svg/download.svg")),
                                              ),
                                            ));
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
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
