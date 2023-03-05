import 'package:rs/src/global/models/courses/questio.dart';

class Assign {
  int id;
  Question question_bank;
  Assign({required this.id, required this.question_bank});
  factory Assign.fromJson(Map<String, dynamic> json) {
    return Assign(
        id: json['id'],
        question_bank: Question.fromJson(json["question_bank"]));
  }
}
