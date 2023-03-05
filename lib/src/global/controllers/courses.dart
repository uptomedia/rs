import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:rs/src/global/controllers/auth.dart';
import 'package:rs/src/global/models/courses/course.dart';
import 'package:rs/src/global/models/courses/courseDetails.dart';
import 'package:rs/src/global/models/courses/course_details_response.dart';
import 'package:rs/src/global/models/courses/courses_responce.dart';
import 'package:rs/src/global/models/courses/lesson.dart';
import 'package:rs/src/global/models/courses/lesson_quiz_details.dart';
import 'package:rs/src/global/models/courses/lesson_quiz_details_res.dart';
import 'package:rs/src/global/models/courses/quiz_test_res.dart';
import 'package:rs/src/global/services/courses_service.dart';
import 'package:path_provider/path_provider.dart';

class CourseController extends GetxController {
  List<Course> fav = [];
  Box? favBox;
  CoursesService servise = CoursesService();
  bool downloading = false;

  String progress = '0';

  bool isDownloaded = false;

  String uri =
      'https://file-examples.com/wp-content/uploads/2017/10/file-example_PDF_1MB.pdf'; // url of the file to be downloaded

  String filename = 'test.pdf'; // file name that you desire to keep

  // downloading logic is handled by this method
  CourseController() {
    init();
  }
  Future<void> init() async {
    favBox = await Hive.openBox("token");
    var f = favBox!.get("fav");
    if (f is List<Course>) {
      fav = f;
    }
    // print(fav[0].title);
    update();
  }

  Future<void> addToFav(Course course) async {
    Course? ff = fav.firstWhere(
      (element) => element.id == course.id,
      orElse: () => Course(
          id: 0,
          count: 0,
          duration: 0,
          title: "title",
          image: "image",
          subscription: 0,
          price: 0),
    );
    if (ff.id == 0) {
      fav.add(course);
      await favBox!.put("fav", fav);
      Get.snackbar("Done", "added to favorite");
      update();
    } else {
      fav.removeWhere((element) => element.id == ff.id);
      await favBox!.put("fav", fav);
      Get.snackbar("Done", "removed from favorite");
      update();
    }
    print(fav.length);
  }

  Future<void> downloadFile(uri, fileName) async {
    downloading = true;
    update();
    String savePath = await getFilePath(fileName);

    Dio dio = Dio();

    dio.download(
      uri,
      savePath,
      onReceiveProgress: (rcv, total) {
        print(
            'received: ${rcv.toStringAsFixed(0)} out of total: ${total.toStringAsFixed(0)}');

        progress = ((rcv / total) * 100).toStringAsFixed(0);

        if (progress == '100') {
          isDownloaded = true;
          update();
        } else if (double.parse(progress) < 100) {
          update();
        }
        update();
      },
      deleteOnError: true,
    ).then((_) {
      if (progress == '100') {
        isDownloaded = true;
        Get.snackbar("Done", "File Downloaded check your downloads folder");
      }

      downloading = false;
      update();
    }).onError((error, stackTrace) {
      Get.snackbar("Error", "Permession Denied");
      downloading = false;
      update();
    });
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';

    path = '/storage/emulated/0/Download/$uniqueFileName.pdf';

    return path;
  }

  AuthController auth = Get.find<AuthController>();
  Future<CoursesResponce> getPopularCourses() async {
    CoursesResponce responce = await servise.getPopularCourses(auth.token);
    if (responce.success) return responce;
    Get.snackbar("Error", responce.message);
    return responce;
  }

  Future<List<Course>> searchCourses(String title) async {
    CoursesResponce responce = await servise.searchCourses(auth.token, title);
    if (responce.success) return responce.data ?? [];
    Get.snackbar("Error", responce.message);
    return responce.data ?? [];
  }

  Future<CourseDetailsResponce> getCourseDetails(dynamic id) async {
    CourseDetailsResponce responce =
        await servise.getCourseDetails(auth.token, id);
    if (responce.success) return responce;
    Get.snackbar("Error", responce.message);
    return responce;
  }

  Future<LessonQuizDetailsResponse> getQuizDetails(dynamic id) async {
    LessonQuizDetailsResponse responce =
        await servise.getLessonQuizDetails(auth.token!, id);
    if (responce.success) return responce;
    Get.snackbar("Error", responce.message);
    return responce;
  }

  Future<CoursesResponce> buyCourse(dynamic id) async {
    CoursesResponce responce = await servise.buyCourse(auth.token!, id);
    if (responce.success) return responce;
    Get.snackbar("Error", responce.message);
    return responce;
  }

  Future<QuizTestResponse> startQuiz(
      LessonQuizDetails quiz, CourseDetails course) async {
    QuizTestResponse responce =
        await servise.startQuiz(auth.token!, quiz, course);
    if (responce.result) return responce;
    Get.snackbar("Error", responce.message!);
    return responce;
  }

  Future<void> completeLesson(Lesson quiz, CourseDetails course) async {
    await servise.completeLesson(auth.token!, quiz, course);

    return;
  }
}

class CourseBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CourseController>(CourseController());
  }
}
