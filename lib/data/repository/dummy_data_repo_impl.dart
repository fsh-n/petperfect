import 'package:petperfect/data/repository/abstract/api.dart';
import 'package:petperfect/domain/repository/dummy_data_repo.dart';

import '../model/DummyDataModel.dart';

class DummyDataRepositoryImpl implements DummyDataRepository {
  // Abstract  Api
  final Api _api;

  DummyDataRepositoryImpl(this._api);

  @override
  Future<List<DummyDataModel>> fetchDummyData() async {
    final result = await _api.fetchDummyData();
    return result;
  }
}
