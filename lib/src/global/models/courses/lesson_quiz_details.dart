import 'package:rs/src/global/models/courses/assign.dart';

class LessonQuizDetails {
  int id, course_id, percentage;
  String title, instruction;
  int is_taken, is_closed, question_time;
  List<Assign> assign = [];
  LessonQuizDetails(
      {required this.id,
      required this.course_id,
      required this.title,
      required this.percentage,
      required this.instruction,
      this.is_closed = 0,
      this.is_taken = 0,
      this.question_time = 0,
      this.assign = const []});
  factory LessonQuizDetails.fromJson(Map<String, dynamic> json) {
    List<Assign> as = [];
    if (json["assign"] != null) {
      as = (json['assign'] as List).map((e) => Assign.fromJson(e)).toList();
    }
    return LessonQuizDetails(
        id: json["id"] ?? 0,
        course_id: json["course_id"] ?? 0,
        title: json['title']['en'].toString(),
        percentage: json['percentage'],
        instruction: json["instruction"]['en'],
        is_closed: json["is_closed"],
        is_taken: json["is_taken"],
        question_time: json["question_time"] ?? 0,
        assign: as);
  }
}
