import 'package:petperfect/domain/repository/image_repository.dart';
import 'package:petperfect/domain/usecase/base_use_case.dart';

abstract class SaveImageUrlUseCase extends BaseUseCase<void, String> {}

class SaveImageUrlUseCaseImpl implements SaveImageUrlUseCase {
  final ImageRepository imageRepository;

  SaveImageUrlUseCaseImpl(this.imageRepository);

  @override
  Future<void> execute(String imageUrl) async {
    await imageRepository.saveImageUrl(imageUrl);
  }
}
