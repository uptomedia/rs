import '../User/user.dart';

class OtpReq {
  final User user;
  var otp;
  OtpReq({required this.user, required this.otp});
  Map<String, dynamic> toJSON() {
    return {"phone": user.id, "password": otp};
  }
}
