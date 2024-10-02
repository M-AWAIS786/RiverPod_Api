import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:riverpod_flutter/model/commentModel.dart';
import 'package:riverpod_flutter/model/photoModel.dart';
import 'package:riverpod_flutter/model/postsModel.dart';

class HttpGetServices {
  static const baseUrl = 'https://jsonplaceholder.typicode.com/';

  Future<List<Post>> getPosts() async {
    final endPoint = 'posts';
    List<Post> postlist = [];
    try {
      final url = Uri.parse('$baseUrl$endPoint');
      final result = await http.get(url);

      if (result.statusCode == 200) {
        List<dynamic> postsList = convert.jsonDecode(result.body);

        for (var postListItem in postsList) {
          Post postModel = Post.fromMap(postListItem);
          postlist.add(postModel);
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return postlist;
  }

  Future<List<PhotoModel>> getPhotos() async {
    final endPoint = 'photos';
    List<PhotoModel> photolist = [];

    try {
      final url = '$baseUrl$endPoint';
      final response = await http.get(Uri.parse(url));
      print(response.body);

      if (response.statusCode == 200) {
        List<dynamic> photodata = convert.jsonDecode(response.body);
        for (var photo in photodata) {
          PhotoModel photoModel = PhotoModel.fromMap(photo);
          photolist.add(photoModel);
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return photolist;
  }

  Future<List<CommentModel>> getComments() async {
    final endPoint = 'comments';
    List<CommentModel> commentlist = [];

    try {
      final url = Uri.parse('$baseUrl$endPoint');
      final response = await http.get(url);
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> commentdata = convert.jsonDecode(response.body);
        for (var comment in commentdata) {
          CommentModel commentModel = CommentModel.fromMap(comment);
          commentlist.add(commentModel);
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return commentlist;
  }
}
