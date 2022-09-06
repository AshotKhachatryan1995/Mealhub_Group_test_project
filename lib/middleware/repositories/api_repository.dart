import '../models/user.dart';

abstract class ApiRepository {
  Future<dynamic> getPosts();
  Future<dynamic> getUser();
  Future<dynamic> getPhotos();
  Future<dynamic> saveDetails({required User user});
}
