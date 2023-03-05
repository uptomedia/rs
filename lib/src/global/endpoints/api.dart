import '../utils/config.dart';

class ApiendPoints {
  static String root = '${AppConfig.baseUrl}/';

  static String baseApi = '${root}api/';
  static String getUser = '${baseApi}user';
  static String getSocial = '${baseApi}social-links';
  static String login(String email, String password) {
    return '${baseApi}login?email=$email&password=$password';
  }

  static String signup(String name, String email, String password) {
    return '${baseApi}signup?name=$name&email=$email&password=$password';
  }

  static String getCourseDetails(dynamic id) {
    return "${baseApi}get-course-details/${id}";
  }

  static String buyCourse(dynamic id) {
    return "${baseApi}buy-now/${id}";
  }

  static String getQuizDetails(dynamic id) {
    return "${baseApi}get-lesson-quiz-details/${id}";
  }

  static String getStartQuiz(dynamic course, quiz) {
    return "${baseApi}quiz-start/${course}/${quiz}";
  }

  static String getQuizResult(dynamic course, quiz) {
    return "${baseApi}quiz-result/${course}/${quiz}";
  }

  static String getSubmitAnswer() {
    return "${baseApi}quiz-single-submit";
  }

  static String getFinalSubmit() {
    return "${baseApi}quiz-final-submit";
  }

  static String lessonComplete(String course_id, String lesson_id) {
    return '${baseApi}lesson-complete?course_id=$course_id&lesson_id=$lesson_id';
  }

  static String popularCourses = "${baseApi}get-popular-courses";
  static String searchCourses = "${baseApi}search-course";
}
