class SubmitAns {
  String type = 'M';
  int assign_id, quiz_test_id;
  List<int> ans;
  SubmitAns(
      {this.type = 'M',
      required this.assign_id,
      required this.quiz_test_id,
      this.ans = const []});
  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "assign_id": assign_id,
      "quiz_test_id": quiz_test_id,
      "ans": ans
    };
  }
}
