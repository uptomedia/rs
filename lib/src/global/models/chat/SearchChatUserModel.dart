import 'dart:convert';

import 'ChatUser.dart';

SearchChatUserModel searchChatUserModelFromJson(String str) =>
    SearchChatUserModel.fromJson(json.decode(str));

String searchChatUserModelToJson(SearchChatUserModel data) =>
    json.encode(data.toJson());

class SearchChatUserModel {
  SearchChatUserModel({
    required this.keywords,
    required this.users,
  });

  String keywords;
  List<ChatUser> users;

  factory SearchChatUserModel.fromJson(Map<String, dynamic> json) =>
      SearchChatUserModel(
        keywords: json["keywords"],
        users:
            List<ChatUser>.from(json["users"].map((x) => ChatUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "keywords": keywords,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}
