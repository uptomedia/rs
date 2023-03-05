class Lesson {
  int id, course_id, chapter_id;
  String name, description, video_url;
  Lesson(
      {required this.id,
      required this.course_id,
      required this.chapter_id,
      required this.name,
      required this.description,
      required this.video_url});
  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
        id: json["id"] ?? 0,
        course_id: json["course_id"] ?? 0,
        chapter_id: json['chapter_id'] ?? 0,
        name: json['name'].toString(),
        description: json['description'].toString(),
        video_url: json['video_url'].toString());
  }
}
