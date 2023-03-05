class QuizTest {
  int user_id, course_id, quiz_id, id;
  QuizTest(
      {required this.user_id,
      required this.course_id,
      required this.quiz_id,
      required this.id});
  factory QuizTest.fromJson(Map<String, dynamic> json) {
    return QuizTest(
        user_id: json["user_id"],
        course_id: int.parse(json["course_id"].toString()),
        quiz_id: int.parse(json["quiz_id"].toString()),
        id: json["id"]);
  }
}
