import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:petperfect/domain/usecase/base_use_case.dart';
import 'package:petperfect/domain/usecase/get_image_url_use_case.dart';
import 'package:petperfect/domain/usecase/save_image_url_use_case.dart';
import 'package:petperfect/presentation/features/screen1/bloc/image_bloc.dart';

class MockGetImageUrlCase extends Mock implements GetImageUrlUseCase {}

class MockSaveImageUrlCase extends Mock implements SaveImageUrlUseCase {}

void main() {
  final _mockGetImageUrlCase = MockGetImageUrlCase();
  final _mockSaveImageUrlCase = MockSaveImageUrlCase();

  //Get Image url case
  const tImageUrl =
      'https://random.dog/a338fdf7-70aa-4a26-a2c2-357cdede7991.jpg';

  group('$ImageBloc', () {
    blocTest<ImageBloc, ImageState>(
      'Should return ImageLoaded state when mockImageUrlCase is called ',
      setUp: () => when(() => _mockGetImageUrlCase
          .execute(NoParams())
          .then((_) async => tImageUrl)),
      build: () => ImageBloc(_mockGetImageUrlCase, _mockSaveImageUrlCase),
      act: (bloc) {
        bloc.add(GetImageUrl());
      },
      expect: () => [isA<ImageState>()],
    );

    blocTest<ImageBloc, ImageState>(
      'Should return tImageUrl when mockImageUrlCase is called ',
      setUp: () => when(() => _mockGetImageUrlCase.execute(NoParams()))
          .thenAnswer((_) async => tImageUrl),
      build: () => ImageBloc(_mockGetImageUrlCase, _mockSaveImageUrlCase),
      act: (bloc) {
        bloc.add(GetImageUrl());
      },
      expect: () => [ImageLoaded(imageUrl: tImageUrl)],
    );

    blocTest<ImageBloc, ImageState>(
      'Should return ImageFailure when mockImageUrlCase is called ',
      build: () => ImageBloc(_mockGetImageUrlCase, _mockSaveImageUrlCase),
      act: (bloc) {
        bloc.add(GetImageUrl());
      },
      expect: () => [isA<ImageFailure>()],
    );
  });
}
