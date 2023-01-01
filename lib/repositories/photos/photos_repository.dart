import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:photos_api/models/photo_model.dart';
import 'package:photos_api/repositories/repositories.dart';
import 'package:photos_api/.env.dart';

class PhotosRepository extends BasePhotoRepository {
  static const String _unsplashBaseUrl = 'https://api.unsplash.com';
  static const int numPerPage = 10;

  final http.Client _httpClient;

  PhotosRepository({required http.Client httpClient})
      : _httpClient = httpClient;

  @override
  Future<List<Photo>> searchPhotos(
      {required String query, int page = 1}) async {
    final url =
        '$_unsplashBaseUrl/search/photos?client_id=$unsplashApiKey&page=$page&per_page=$numPerPage&query=$query';

    final response = await _httpClient.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List result = data['results'];
      final List<Photo> photos = result.map((e) => Photo.fromMap(e)).toList();
      return photos;
    }

    return [];
  }

  @override
  void dispose() {
    _httpClient.close();
  }
}
