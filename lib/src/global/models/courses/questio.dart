import 'package:rs/src/global/models/courses/ans.dart';

class Question {
  int id, marks;
  String question;
  List<Answer> question_mu = [];
  Question(
      {required this.id,
      required this.marks,
      required this.question,
      this.question_mu = const []});
  factory Question.fromJson(Map<String, dynamic> json) {
    List<Answer> ans = [];
    if (json['question_mu'] != null) {
      ans = (json["question_mu"] as List)
          .map((e) =>
              Answer(id: e['id'], status: e['status'], title: e['title']))
          .toList();
    }
    return Question(
        id: json["id"],
        marks: json['marks'],
        question: json['question'],
        question_mu: ans);
  }
}
