import 'package:rs/src/global/models/courses/courseDetails.dart';

class CourseDetailsResponce {
  bool success;
  String message;
  CourseDetails? data;
  CourseDetailsResponce(
      {required this.success, required this.data, required this.message});
  factory CourseDetailsResponce.fromJson(Map<String, dynamic> json) {
    return CourseDetailsResponce(
        success: json['success'],
        data: CourseDetails.fromJson(json['data']),
        message: json['message']);
  }
  factory CourseDetailsResponce.empty(String? msg) {
    return CourseDetailsResponce(
        success: false, data: null, message: msg ?? "");
  }
}
