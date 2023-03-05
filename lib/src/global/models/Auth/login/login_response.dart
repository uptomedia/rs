import '../../User/user.dart';

class LoginResponse {
  final User user;
  final String token;
  String? message;
  int? status;
  LoginResponse(
      {required this.user, required this.token, this.message, this.status});
  factory LoginResponse.fromJson(Map<String, dynamic> data) {
    return LoginResponse(user: User.empty(), token: data["access_token"]);
  }
  factory LoginResponse.empty(String msg, {int? status, User? user}) {
    return LoginResponse(
        user: User.empty(), token: "", message: msg, status: status);
  }
}
