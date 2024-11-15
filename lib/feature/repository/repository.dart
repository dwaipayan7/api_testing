import 'dart:convert';

import 'package:api_testing/feature/models/posts_model.dart';
import 'package:http/http.dart' as http;

class Repository {
  static Future<List<PostDataUiModel>> fetchPosts() async {
    var client = http.Client();
    List<PostDataUiModel> posts = [];

    try {
      var response = await client
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      // print(response.body);

      List result = jsonDecode(response.body);

      for (int i = 0; i < result.length; i++) {
        PostDataUiModel post =
            PostDataUiModel.fromMap(result[i] as Map<String, dynamic>);
        posts.add(post);
      }
      print(posts);
      return posts;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
