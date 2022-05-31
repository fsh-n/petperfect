import 'package:petperfect/data/model/DummyDataModel.dart';
import 'package:petperfect/domain/repository/dummy_data_repo.dart';
import 'package:petperfect/domain/usecase/base_use_case.dart';

abstract class GetDummyDataUseCase
    extends BaseUseCase<List<DummyDataModel>, NoParams> {}

class GetDummyDataUseCaseImpl implements GetDummyDataUseCase {
  final DummyDataRepository dummyDataRepository;

  GetDummyDataUseCaseImpl(this.dummyDataRepository);

  @override
  Future<List<DummyDataModel>> execute(NoParams params) async {
    final result = dummyDataRepository.fetchDummyData();
    return result;
  }
}
