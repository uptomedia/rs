import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rs/src/global/controllers/courses.dart';
import 'package:rs/src/global/models/courses/course.dart';
import 'package:rs/src/global/widgets/background.dart';
import 'package:rs/src/modules/courses/widgets/course_card.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }

    //Add the search term to the searchBloc.
    //The Bloc will then handle the searching and add the results to the searchResults stream.
    //This is the equivalent of submitting the search term to whatever search service you are using
    CourseController controller = Get.find<CourseController>();

    return Stack(
      children: [
        const Background(),
        Column(
          children: <Widget>[
            //Build the results based on the searchResults stream in the searchBloc
            FutureBuilder(
              future: controller.searchCourses(query),
              builder: (context, AsyncSnapshot<List<Course>> snapshot) {
                if (!snapshot.hasData) {
                  return const Expanded(
                      child: Center(child: CircularProgressIndicator()));
                } else if (snapshot.data!.isEmpty) {
                  return Column(
                    children: const [
                      Text(
                        "No Results Found.",
                      ),
                    ],
                  );
                } else {
                  var results = snapshot.data;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: results!.length,
                      itemBuilder: (context, index) {
                        var result = results[index];
                        return CourseCard(course: result);
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return Column();
  }
}

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showSearch(context: context, delegate: CustomSearchDelegate());
      },
      child: Row(
        children: const [
          Icon(Icons.search),
          SizedBox(
            width: 20,
          ),
          Text("البحث"),
        ],
      ),
    );
  }
}
