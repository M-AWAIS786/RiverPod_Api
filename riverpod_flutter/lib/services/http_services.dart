import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:riverpod_flutter/model/postsModel.dart';

class HttpGetServices {
  static const baseUrl = 'https://jsonplaceholder.typicode.com/';
  static const endPoint = 'posts';

  Future<List<Post>> getPosts() async {
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
}
