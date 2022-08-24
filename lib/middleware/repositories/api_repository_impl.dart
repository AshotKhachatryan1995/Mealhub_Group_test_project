import 'dart:convert';

import 'package:Mealhub_Group_test_project/middleware/constants/app_urls.dart';
import 'package:Mealhub_Group_test_project/middleware/models/api_error_model.dart';
import 'package:Mealhub_Group_test_project/middleware/models/post.dart';
import 'package:Mealhub_Group_test_project/middleware/repositories/api_repository.dart';
import 'package:http/http.dart' as http;

class ApiRepositoryImpl implements ApiRepository {
  @override
  Future<dynamic> getPhotos() async {}

  @override
  Future<dynamic> getPosts() async {
    try {
      final response =
          await http.get(Uri.parse(AppUrls.baseUrl + AppUrls.postsUrl));

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body) as List;
        final posts = result.map((e) => Post.fromJson(e)).toList();

        return posts;
      } else {
        return ApiErrorModel(
            errorCode: response.statusCode, errorMessage: response.toString());
      }
    } catch (e) {
      return ApiErrorModel(errorCode: 400, errorMessage: e.toString());
    }
  }

  @override
  Future<dynamic> getUser() async {}
}
