import '../../model/DummyDataModel.dart';

abstract class Api {
  // Get Image url to load image
  Future<String> fetchImageUrl();

  // Get Dummy data
  Future<List<DummyDataModel>> fetchDummyData();
}
