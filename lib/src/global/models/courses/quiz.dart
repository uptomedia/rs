class Quiz {
  int id, course_id, percentage;
  String title, instruction;
  int is_taken, is_closed;

  Quiz(
      {required this.id,
      required this.course_id,
      required this.title,
      required this.percentage,
      required this.instruction,
      this.is_closed = 0,
      this.is_taken = 0});
  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
        id: json["id"] ?? 0,
        course_id: json["course_id"] ?? 0,
        title: json['title']['en'].toString(),
        percentage: json['percentage'],
        instruction: json["instruction"]['en'],
        is_closed: json["is_closed"],
        is_taken: json["is_taken"]);
  }
}
