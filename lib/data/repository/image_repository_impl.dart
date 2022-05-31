import 'package:hive_flutter/adapters.dart';
import 'package:petperfect/data/repository/abstract/api.dart';
import 'package:petperfect/domain/repository/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  // Abstract  Api
  final Api _api;

  ImageRepositoryImpl(this._api);

  @override
  Future<String> fetchImageUrl() async {
    final result = await _api.fetchImageUrl();
    return result;
  }

  @override
  Future<void> saveImageUrl(String imageUrl) async {
    final box = await Hive.openBox('images');
    box.put('current_image', imageUrl);
  }
}
