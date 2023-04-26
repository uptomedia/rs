import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class QuizResult {
  int id, quiz_id, result, maxResult, pass;
  String duration;
  List<QusRes> questions;
  QuizResult(
      {required this.id,
      required this.quiz_id,
      required this.result,
      required this.maxResult,
      required this.pass,
      required this.duration,
      required this.questions});

  factory QuizResult.fromJson(
      Map<String, dynamic> json, int result, int maxRes) {
    return QuizResult(
        id: json["id"],
        quiz_id: json['quiz_id'],
        result: result,
        maxResult: maxRes,
        pass: json['pass'],
        duration: json['duration'],
        questions: List<QusRes>.from(
          (json['questions'] as List<dynamic>).map<QusRes>(
            (x) => QusRes.fromJson(x as Map<String, dynamic>),
          ),
        ));
  }
  factory QuizResult.empty() {
    return QuizResult(
        id: -1,
        quiz_id: -1,
        result: 0,
        maxResult: 0,
        pass: 0,
        duration: 'duration',
        questions: []);
  }
}

class QusRes {
  String qus;
  bool isWrong;
  List<QusOpt> option;
  QusRes({
    required this.qus,
    required this.isWrong,
    required this.option,
  });

  factory QusRes.fromJson(Map<String, dynamic> map) {
    return QusRes(
      qus: map['qus'] as String,
      isWrong: map['isWrong'] as bool,
      option: List<QusOpt>.from(
        (map['option'] as List<dynamic>).map<QusOpt>(
          (x) => QusOpt.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

class QusOpt {
  String title;
  bool right;
  QusOpt({
    required this.title,
    required this.right,
  });

  factory QusOpt.fromJson(Map<String, dynamic> map) {
    return QusOpt(
      title: map['title'] as String,
      right: map['right'] as bool,
    );
  }
}
