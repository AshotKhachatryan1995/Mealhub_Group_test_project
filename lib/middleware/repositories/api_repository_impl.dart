import 'package:Mealhub_Group_test_project/middleware/constants/app_urls.dart';
import 'package:Mealhub_Group_test_project/middleware/repositories/api_repository.dart';
import 'package:http/http.dart' as http;

class ApiRepositoryImpl implements ApiRepository {
  @override
  Future<dynamic> getPhotos() async {}

  @override
  Future<dynamic> getPosts() async {
    final response =
        await http.get(Uri.parse(AppUrls.baseUrl + AppUrls.postsUrl));

    print(response.statusCode);
  }

  @override
  Future<dynamic> getUser() async {}
}
