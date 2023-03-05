class Chapter {
  int id, course_id;
  String name;
  Chapter({required this.id, required this.course_id, required this.name});
  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
        id: json['id'] ?? 0,
        course_id: json['course_id'] ?? 0,
        name: json['name'].toString());
  }
}
