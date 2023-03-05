import 'package:rs/src/global/models/courses/chapter.dart';
import 'package:rs/src/global/models/courses/file.dart';
import 'package:rs/src/global/models/courses/lesson.dart';
import 'package:rs/src/global/models/courses/quiz.dart';

class CourseDetails {
  int id, count, duration, subscription;
  double price;
  double? discount_price;
  String title, description;
  String? image;
  List<Chapter> chapters;
  List<Lesson> lessons;
  List<File> files;
  List<Quiz> quiz;
  CourseDetails(
      {required this.id,
      required this.count,
      required this.duration,
      required this.title,
      this.description = "",
      required this.image,
      required this.subscription,
      required this.price,
      this.discount_price,
      this.chapters = const [],
      this.lessons = const [],
      this.files = const [],
      this.quiz = const []});
  factory CourseDetails.fromJson(Map<String, dynamic> json) {
    List<Quiz> qz = [];
    List<Chapter> chs = (json['chapters'] as List)
        .map(
          (e) => Chapter.fromJson(e),
        )
        .toList();
    List<Lesson> lss = (json['lessons'] as List).map(
      (e) {
        if (e['quiz'] != null) {
          qz.addAll((e['quiz'] as List)
              .map(
                (el) => Quiz.fromJson(el),
              )
              .toList());
        }
        return Lesson.fromJson(e);
      },
    ).toList();
    List<File> fls = (json['files'] as List)
        .map(
          (e) => File.fromJson(e),
        )
        .toList();

    return CourseDetails(
        id: json['id'],
        count: json['enrollCount'] ?? 0,
        duration: int.parse(json['duration'].toString()),
        title: json['title']['en'].toString(),
        description: json['meta_description'].toString(),
        image: json['thumbnail'],
        subscription: int.parse(json['subscription'].toString()),
        price: double.parse(json['price'].toString()),
        chapters: chs,
        lessons: lss,
        files: fls,
        quiz: qz);
  }
}
