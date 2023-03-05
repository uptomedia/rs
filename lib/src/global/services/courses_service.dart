import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rs/src/global/exceptions/app_exceptions.dart';
import 'package:rs/src/global/models/courses/courseDetails.dart';
import 'package:rs/src/global/models/courses/course_details_response.dart';
import 'package:rs/src/global/models/courses/courses_responce.dart';
import 'package:rs/src/global/models/courses/lesson.dart';
import 'package:rs/src/global/models/courses/lesson_quiz_details.dart';
import 'package:rs/src/global/models/courses/lesson_quiz_details_res.dart';
import 'package:rs/src/global/models/courses/quiz_test_res.dart';
import 'package:rs/src/global/models/courses/submit_ans.dart';

import '../endpoints/api.dart';

class CoursesService {
  Future<CoursesResponce> getPopularCourses(String? token) async {
    try {
      var data = await httpCall.get(ApiendPoints.popularCourses,
          options: Options(
              headers: token != null
                  ? {HttpHeaders.authorizationHeader: "Bearer $token"}
                  : {}));
      print(data.statusCode);
      if (data.statusCode == 200) {
        print((data.data as Map).keys.toList().join(","));
        if (data.data["success"] as bool) {
          return CoursesResponce.fromJson(data.data);
        }
        return CoursesResponce.empty(data.data["message"]);
      }
      return CoursesResponce.empty(data.statusMessage ?? "");
    } on DioError catch (e) {
      print(e.message);
      if (e.response != null) print(e.response!.data);
      if (e.type == DioErrorType.other) {
        return CoursesResponce.empty("Please Check the Internet Connection");
      }
      return CoursesResponce.empty(
        e.message,
      );
    }
  }

  Future<CoursesResponce> searchCourses(String? token, String title) async {
    try {
      var data = await httpCall.get(
          "${ApiendPoints.searchCourses}?title=$title",
          options: Options(
              headers: token != null
                  ? {HttpHeaders.authorizationHeader: "Bearer $token"}
                  : {}));
      print(data.statusCode);
      if (data.statusCode == 200) {
        print((data.data as Map).keys.toList().join(","));
        if (data.data["success"] as bool) {
          return CoursesResponce.fromJson(data.data);
        }
        return CoursesResponce.empty(data.data["message"]);
      }
      return CoursesResponce.empty(data.statusMessage ?? "");
    } on DioError catch (e) {
      print(e.message);
      if (e.response != null) print(e.response!.data);
      if (e.type == DioErrorType.other) {
        return CoursesResponce.empty("Please Check the Internet Connection");
      }
      return CoursesResponce.empty(
        e.message,
      );
    }
  }

  Future<CourseDetailsResponce> getCourseDetails(
      String? token, dynamic id) async {
    print(token);
    try {
      var data = await httpCall.get(ApiendPoints.getCourseDetails(id),
          options: Options(
              headers: token != null
                  ? {HttpHeaders.authorizationHeader: "Bearer $token"}
                  : {}));
      print(data.statusCode);
      if (data.statusCode == 200) {
        print((data.data));
        try {
          if (data.data["success"] as bool) {
            return CourseDetailsResponce.fromJson(data.data);
          }
          return CourseDetailsResponce.empty(data.data["message"].toString());
        } on Exception catch (e) {
          print(e);
        }
      }
      return CourseDetailsResponce.empty(data.statusMessage ?? "");
    } on DioError catch (e) {
      print(e.message);
      if (e.response != null) print(e.response!.data);
      if (e.type == DioErrorType.other) {
        return CourseDetailsResponce.empty(
            "Please Check the Internet Connection");
      }
      return CourseDetailsResponce.empty(
        e.message,
      );
    }
  }

  Future<CoursesResponce> buyCourse(String token, dynamic id) async {
    try {
      var data = await httpCall.get(ApiendPoints.buyCourse(id),
          options: Options(
              headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));
      print(data.statusCode);
      if (data.statusCode == 200) {
        print((data.data as Map).keys.toList().join(","));
        if (data.data["success"] as bool) {
          return CoursesResponce.fromJson(data.data);
        }
        return CoursesResponce.empty(data.data["message"]);
      }
      return CoursesResponce.empty(data.statusMessage ?? "");
    } on DioError catch (e) {
      print(e.message);
      if (e.response != null) print(e.response!.data);
      if (e.type == DioErrorType.other) {
        return CoursesResponce.empty("Please Check the Internet Connection");
      }
      return CoursesResponce.empty(
        e.message,
      );
    }
  }

  Future<LessonQuizDetailsResponse> getLessonQuizDetails(
      String token, dynamic id) async {
    try {
      var data = await httpCall.get(ApiendPoints.getQuizDetails(id),
          options: Options(
              headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));
      print(data.statusCode);
      if (data.statusCode == 200) {
        print((data.data as Map).keys.toList().join(","));
        if (data.data["success"] as bool) {
          print(data.data["data"]);
          return LessonQuizDetailsResponse.fromJson(data.data);
        }
        return LessonQuizDetailsResponse.empty(data.data["message"]);
      }
      return LessonQuizDetailsResponse.empty(data.statusMessage ?? "");
    } on DioError catch (e) {
      print(e.message);
      if (e.response != null) print(e.response!.data);
      if (e.type == DioErrorType.other) {
        return LessonQuizDetailsResponse.empty(
            "Please Check the Internet Connection");
      }
      return LessonQuizDetailsResponse.empty(
        e.message,
      );
    }
  }

  Future<QuizTestResponse> startQuiz(
      String token, LessonQuizDetails quiz, CourseDetails course) async {
    try {
      var data = await httpCall.post(
          ApiendPoints.getStartQuiz(course.id, quiz.id),
          options: Options(
              headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));
      print(data.statusCode);
      if (data.statusCode == 200) {
        print((data.data as Map).keys.toList().join(","));
        if (data.data["data"] != null) {
          return QuizTestResponse.fromJson(data.data);
        }
        return QuizTestResponse.empty("failed to start try again later");
      }
      return QuizTestResponse.empty(data.statusMessage ?? "");
    } on DioError catch (e) {
      print(e.message);
      if (e.response != null) print(e.response!.data);
      if (e.type == DioErrorType.other) {
        return QuizTestResponse.empty("Please Check the Internet Connection");
      }
      return QuizTestResponse.empty(
        e.message,
      );
    }
  }

  Future<void> completeLesson(
      String token, Lesson lesson, CourseDetails course) async {
    try {
      var data = await httpCall.get(
          ApiendPoints.lessonComplete(
              course.id.toString(), lesson.id.toString()),
          options: Options(
              headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));
      print(data.statusCode);
      if (data.statusCode == 200) {
        print(data.data);

        return;
      }
      return;
    } on DioError catch (e) {
      print(e.message);
      if (e.response != null) print(e.response!.data);
      if (e.type == DioErrorType.other) {
        return;
      }
      return;
    }
  }

  Future<void> submitAns(String token, SubmitAns ans) async {
    try {
      var data = await httpCall.post(ApiendPoints.getSubmitAnswer(),
          data: ans.toJson(),
          options: Options(
              headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));
      print(data.statusCode);
      if (data.statusCode == 200) {
        print("data:${data.data}");

        return;
      }
      return;
    } on DioError catch (e) {
      print(e.message);
      if (e.response != null) print(e.response!.data);
      if (e.type == DioErrorType.other) {
        return;
      }
      return;
    }
  }

  Future<void> finalSubmit(String token, int id) async {
    try {
      var data = await httpCall.post(ApiendPoints.getFinalSubmit(),
          data: {"quiz_test_id": id, "type": []},
          options: Options(
              headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));
      print(data.statusCode);
      if (data.statusCode == 200) {
        print("data:${data.data}");

        return;
      }
      return;
    } on DioError catch (e) {
      print(e.message);
      if (e.response != null) print(e.response!.data);
      if (e.type == DioErrorType.other) {
        return;
      }
      return;
    }
  }

  Future<void> quizResult(String token, int c_id, int q_id) async {
    try {
      var data = await httpCall.post(ApiendPoints.getQuizResult(c_id, q_id),
          options: Options(
              headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));
      print(data.statusCode);
      if (data.statusCode == 200) {
        print("data:${data.data}");

        return;
      }
      return;
    } on DioError catch (e) {
      print(e.message);
      if (e.response != null) print(e.response!.data);
      if (e.type == DioErrorType.other) {
        return;
      }
      return;
    }
  }
}
