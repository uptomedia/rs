import 'package:hive/hive.dart';
part 'course.g.dart';

@HiveType(typeId: 0)
class Course extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  int count;
  @HiveField(2)
  int duration;
  @HiveField(3)
  int subscription;
  @HiveField(4)
  double price;
  @HiveField(5)
  double? discount_price;
  @HiveField(6)
  String title;
  @HiveField(7)
  String? image;
  Course(
      {required this.id,
      required this.count,
      required this.duration,
      required this.title,
      required this.image,
      required this.subscription,
      required this.price,
      this.discount_price});
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
        id: json['id'],
        count: json['enrollCount'],
        duration: int.parse(json['duration']),
        title: json['title']['en'],
        image: json['thumbnail'],
        subscription: int.parse(json['subscription']),
        price: double.parse(json['price'].toString()));
  }
}
