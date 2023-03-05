class File {
  int id, course_id;
  String fileName, file;
  File(
      {required this.id,
      required this.course_id,
      required this.fileName,
      required this.file});
  factory File.fromJson(Map<String, dynamic> json) {
    return File(
        id: json["id"],
        course_id: json["course_id"],
        fileName: json["fileName"],
        file: json["file"]);
  }
}
