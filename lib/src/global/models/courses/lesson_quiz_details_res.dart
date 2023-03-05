import 'package:rs/src/global/models/courses/lesson_quiz_details.dart';

class LessonQuizDetailsResponse {
  bool success;
  String message;
  LessonQuizDetails? data;
  LessonQuizDetailsResponse(
      {required this.success, required this.message, this.data});
  factory LessonQuizDetailsResponse.fromJson(Map<String, dynamic> json) {
    return LessonQuizDetailsResponse(
        success: json["success"],
        message: json["message"],
        data: LessonQuizDetails.fromJson(json['data']['quiz']));
  }
  factory LessonQuizDetailsResponse.empty(String msg) {
    return LessonQuizDetailsResponse(success: false, message: msg);
  }
}
