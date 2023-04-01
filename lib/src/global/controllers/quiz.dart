import 'dart:async';

import 'package:get/get.dart';
import 'package:rs/src/global/controllers/auth.dart';
import 'package:rs/src/global/models/courses/ans.dart';
import 'package:rs/src/global/models/courses/courseDetails.dart';

import 'package:rs/src/global/models/courses/lesson_quiz_details.dart';
import 'package:rs/src/global/models/courses/lesson_quiz_details_res.dart';
import 'package:rs/src/global/models/courses/quiz_result.dart';
import 'package:rs/src/global/models/courses/quiz_test.dart';
import 'package:rs/src/global/models/courses/quiz_test_res.dart';
import 'package:rs/src/global/models/courses/submit_ans.dart';
import 'package:rs/src/global/services/courses_service.dart';
import 'package:rs/src/modules/courses/course_quiz.dart';
import 'package:rs/src/modules/courses/courses_screen.dart';
import 'package:rs/src/modules/courses/quiz_done.dart';
import 'package:rs/src/modules/home/home_screen.dart';

class QuizController extends GetxController {
  CoursesService servise = CoursesService();
  QuizTest? currentQuizTest;
  LessonQuizDetails? lessonQuizDetails;
  int assignmentIndex = 0;
  Duration assignDuration = Duration(seconds: 0);
  Duration time = Duration(seconds: 0);
  bool downloading = false;
  Timer? timer;
  String progress = '50';
  Answer answer = Answer(id: -1, status: 1, title: "title");
  int result = 0;

  AuthController auth = Get.find<AuthController>();
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer = Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) {
        print(time.inSeconds);
        time = timer.tick.seconds;
        update();
        if (time.inSeconds >= assignDuration.inSeconds) {
          timer.cancel();
        }
      },
    );
  }

  Future<LessonQuizDetailsResponse> getQuizDetails(dynamic id) async {
    LessonQuizDetailsResponse responce =
        await servise.getLessonQuizDetails(auth.token!, id);
    if (responce.success) return responce;
    Get.snackbar("Error", responce.message);
    return responce;
  }

  void calculateProgress() {
    progress =
        (((assignmentIndex + 1) / lessonQuizDetails!.assign.length) * 100)
            .toString();
    update();
  }

  Future<QuizTestResponse> startQuiz(
      LessonQuizDetails quiz, CourseDetails course) async {
    lessonQuizDetails = quiz;
    update();
    QuizTestResponse responce =
        await servise.startQuiz(auth.token!, quiz, course);
    if (responce.result) return responce;
    Get.snackbar("Error", responce.message!);
    timer = Timer(assignDuration, () {
      print("nnnnnnnnnnnnnnnn");
    });

    return responce;
  }

  Future<void> submitAns(SubmitAns ans) async {
    await servise.submitAns(auth.token!, ans);
    if (answer.status == 1) {
      result += lessonQuizDetails!.assign[assignmentIndex].question_bank.marks;
    }
    print("result:$result");
    answer = Answer(id: -1, status: 1, title: "title");
    if (assignmentIndex < lessonQuizDetails!.assign.length - 1) {
      timer!.cancel();
      assignmentIndex++;
      update();
      calculateProgress();
      startTimer();
    } else {
      await finalSubmit();
      print("quizz ${lessonQuizDetails!.id}");
      print("courssss ${lessonQuizDetails!.course_id}");
      QuizResult r = await servise.quizResult(auth.token!,
          lessonQuizDetails!.course_id, currentQuizTest!.id, result);
      Get.offAll(QuizDoneScreen(
        result: r,
      ));
    }
    update();
    return;
  }

  Future<void> finalSubmit() async {
    await servise.finalSubmit(auth.token!, currentQuizTest!.id);

    update();
    return;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    timer!.cancel();
  }
}
