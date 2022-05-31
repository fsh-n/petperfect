import 'package:petperfect/domain/repository/image_repository.dart';
import 'package:petperfect/domain/usecase/base_use_case.dart';

abstract class GetImageUrlUseCase extends BaseUseCase<String, NoParams> {}

class GetImageUrlUseCaseImpl implements GetImageUrlUseCase {
  final ImageRepository imageRepository;

  GetImageUrlUseCaseImpl(this.imageRepository);

  @override
  Future<String> execute(NoParams params) async {
    final result = await imageRepository.fetchImageUrl();
    return result;
  }
}
