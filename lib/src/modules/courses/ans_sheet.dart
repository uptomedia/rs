import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rs/src/global/models/courses/quiz_result.dart';
import 'package:rs/src/global/utils/colors.dart';
import 'package:rs/src/global/widgets/app_bar.dart';
import 'package:rs/src/global/widgets/background.dart';
import 'package:rs/src/modules/home/home_screen.dart';

class AnsSeet extends StatelessWidget {
  final QuizResult result;
  const AnsSeet({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(),
        body: Stack(
          children: [
            const Background(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Center(child: SvgPicture.asset("assets/svg/done.svg")),
                // ),
                Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                    children: result.questions
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(26),
                                child: Container(
                                  width: Get.size.width,
                                  color: AppColors.textFormFill,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              e.qus,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Spacer(),
                                            // Text((!e.isWrong).toString())
                                          ],
                                        ),
                                        const Divider(),
                                        ...e.option.map((op) => Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Container(
                                                    color: op.right
                                                        ? Colors.green
                                                        : Colors.red,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            op.title,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          const Spacer(),
                                                          op.right
                                                              ? const Icon(
                                                                  Icons.check)
                                                              : const Icon(
                                                                  Icons.close,
                                                                ),
                                                          // Text(op.right.toString()),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const Divider()
                                              ],
                                            ))
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                        )
                        .toList(),
                  )),
                ),
                Center(
                  child: SizedBox(
                    width: 160,
                    child: TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            )),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xff427CFC))),
                        onPressed: () async {
                          Get.offAll(HomeScreen());
                        },
                        child: Text(
                          "Back to Home".tr,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        )),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
