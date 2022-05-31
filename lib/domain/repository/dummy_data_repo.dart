import '../../data/model/DummyDataModel.dart';

// Dummy Data Use Case should only depend on this repo to get data
// In this way it will get dummy data without knowing from where it is getting dummy data
// It will provide abstraction and In future we don't need to change use case
// based on remote service or content
abstract class DummyDataRepository {
  // Get dummy data
  Future<List<DummyDataModel>> fetchDummyData();

  // Any other dummy data related content
  // can be defined below

}
