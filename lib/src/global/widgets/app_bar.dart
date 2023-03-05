import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rs/src/modules/courses/fav_courses.dart';
import 'package:rs/src/modules/courses/search.dart';

class MyAppBar extends AppBar {
  MyAppBar({super.key});

  @override
  List<Widget>? get actions => [
        IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_forward_ios))
      ];
  @override
  Widget? get leading => PopupMenuButton(
          // add icon, by default "3 dot" icon
          // icon: Icon(Icons.book),
          itemBuilder: (context) {
        return [
          PopupMenuItem<int>(value: 0, child: SearchButton()),
          PopupMenuItem<int>(
            value: 1,
            child: Row(
              children: const [
                Icon(Icons.favorite_border),
                SizedBox(
                  width: 20,
                ),
                Text("المفضلة"),
              ],
            ),
          ),
        ];
      }, onSelected: (value) {
        if (value == 0) {
        } else if (value == 1) {
          Get.to(const FavCoursesScreen());
        }
      });
}
