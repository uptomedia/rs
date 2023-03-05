import 'package:rs/src/global/models/courses/course.dart';

class CoursesResponce {
  bool success;
  List<Course>? data;
  String message;
  CoursesResponce(
      {required this.success, required this.data, required this.message});
  factory CoursesResponce.fromJson(Map<String, dynamic> json) {
    List<Course> courses = [];
    if (json['data'] != null) {
      courses = (json['data'] as List).map(
        (e) {
          return Course.fromJson(e);
        },
      ).toList();
    }
    return CoursesResponce(
        success: json['success'], data: courses, message: json["message"]);
  }
  factory CoursesResponce.empty(String? msg) {
    return CoursesResponce(success: false, data: [], message: msg ?? "");
  }
}
