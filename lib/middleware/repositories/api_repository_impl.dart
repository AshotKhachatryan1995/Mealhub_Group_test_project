import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mealhub_group_test_project/middleware/models/photo.dart';

import '../constants/app_urls.dart';
import '../models/api_error_model.dart';
import '../models/post.dart';
import '../models/user.dart';
import 'api_repository.dart';

class ApiRepositoryImpl implements ApiRepository {
  @override
  Future<dynamic> getPhotos() async {
    try {
      final response =
          await http.get(Uri.parse(AppUrls.baseUrl + AppUrls.photosUrl));

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body) as List;
        final photosList = result.map((e) => Photo.fromJson(e)).toList()
          ..shuffle();

        final photos = photosList.sublist(0, 3);
        return photos;
      } else {
        return ApiErrorModel(
            errorCode: response.statusCode, errorMessage: response.toString());
      }
    } catch (e) {
      return ApiErrorModel(errorCode: 400, errorMessage: e.toString());
    }
  }

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
  Future<dynamic> getUser() async {
    try {
      final response =
          await http.get(Uri.parse(AppUrls.baseUrl + AppUrls.usersUrl));
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        final user = User.fromJson(result);

        return user;
      } else {
        return ApiErrorModel(
            errorCode: response.statusCode, errorMessage: response.toString());
      }
    } catch (e) {
      return ApiErrorModel(errorCode: 400, errorMessage: e.toString());
    }
  }

  @override
  Future<dynamic> saveDetails({required User user}) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ....'
      };

      final currentUser = user.toJson();

      String jsonBody = json.encode(currentUser);
      final encoding = Encoding.getByName('utf-8');

      final response = await http.post(
        Uri.parse(AppUrls.baseUrl + AppUrls.saveDataUrl),
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return ApiErrorModel(
            errorCode: response.statusCode, errorMessage: response.toString());
      }
    } catch (e) {
      return ApiErrorModel(errorCode: 400, errorMessage: e.toString());
    }
  }
}
