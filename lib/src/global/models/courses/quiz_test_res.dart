import 'package:rs/src/global/models/courses/quiz_test.dart';

class QuizTestResponse {
  String? message;
  bool result;
  QuizTest? data;
  QuizTestResponse({required this.result, this.data, this.message});
  factory QuizTestResponse.fromJson(Map<String, dynamic> json) {
    return QuizTestResponse(
        result: json["result"], data: QuizTest.fromJson(json["data"]));
  }
  factory QuizTestResponse.empty(String msg) {
    return QuizTestResponse(result: false, message: msg);
  }
}
