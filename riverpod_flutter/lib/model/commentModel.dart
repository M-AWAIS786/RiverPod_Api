import 'dart:convert';

import 'package:flutter/foundation.dart';

class CommentModel {
  final int id;
  final String name;
  final String email;
  final String body;

  CommentModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.body});
  CommentModel copyWith({int? id, String? name, String? email, String? body}) {
    return CommentModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        body: body ?? this.body);
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
        id: map['id'],
        name: map['name'],
        email: map['email'],
        body: map['body']);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email, 'body': body};
  }

  factory CommentModel.fromjson(String source) =>
      CommentModel.fromMap(json.decode(source));
  String toJson() => json.encode(toMap());
}
