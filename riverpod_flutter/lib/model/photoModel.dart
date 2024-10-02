import 'dart:convert';

import 'package:riverpod_flutter/model/postsModel.dart';

class PhotoModel {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  PhotoModel(
      {required this.albumId,
      required this.id,
      required this.title,
      required this.url,
      required this.thumbnailUrl});

  // Factory method to create a PhotoModel from a map (used in decoding JSON)
  factory PhotoModel.fromMap(Map<String, dynamic> map) {
    return PhotoModel(
        albumId: map['albumId'] as int,
        id: map['id'] as int,
        title: map['title'] as String,
        url: map['url'] as String,
        thumbnailUrl: map['thumbnailUrl'] as String);
  }
  // Method to convert a PhotoModel instance into a map (used in encoding JSON)
  Map<String, dynamic> toMap() {
    return {
      'albumId': albumId,
      'id': id,
      'title': title,
      'url': url,
      'thumbnailUrl': thumbnailUrl
    };
  }

  // Convert PhotoModel to JSON string
  String toJson() => json.encode(toMap());
  // Convert JSON string to PhotoModel
  factory PhotoModel.fromjson(String source) =>
      PhotoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  PhotoModel copyWith(
      {int? albumId,
      int? id,
      String? title,
      String? url,
      String? thumbnailUrl}) {
    return PhotoModel(
      albumId: albumId ?? this.albumId,
      id: id ?? this.id,
      title: title ?? this.title,
      url: url ?? this.url,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    );
  }
}
