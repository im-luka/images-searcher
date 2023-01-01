import 'package:photos_api/models/models.dart';
import 'package:photos_api/repositories/repositories.dart';

abstract class BasePhotoRepository extends BaseRepository {
  Future<List<Photo>> searchPhotos({required String query, int page = 1});
}
