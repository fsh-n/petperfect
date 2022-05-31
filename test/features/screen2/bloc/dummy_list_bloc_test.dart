import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:petperfect/data/model/DummyDataModel.dart';
import 'package:petperfect/domain/usecase/base_use_case.dart';
import 'package:petperfect/domain/usecase/get_dummy_data_use_case.dart';
import 'package:petperfect/presentation/features/screen2/bloc/dummy_list_bloc.dart';

class MockDummyDataUseCase extends Mock implements GetDummyDataUseCase {}

void main() {
  final _mockDummyDataUseCase = MockDummyDataUseCase();

  //Get Image url case
  const tDummyList = <DummyDataModel>[];

  group('$DummyListBloc', () {
    blocTest<DummyListBloc, DummyListState>(
      'Should return DummyListLoaded state when _mockDummyDataUseCase is called ',
      setUp: () => when(() => _mockDummyDataUseCase.execute(NoParams()))
          .thenAnswer((_) async => tDummyList),
      build: () => DummyListBloc(_mockDummyDataUseCase),
      act: (bloc) {
        bloc.add(FetchDummyListData());
      },
      expect: () => [isA<DummyListLoaded>()],
    );

    blocTest<DummyListBloc, DummyListState>(
      'Should return tDummyList when _mockDummyDataUseCase is called ',
      setUp: () => when(() => _mockDummyDataUseCase.execute(NoParams()))
          .thenAnswer((_) async => tDummyList),
      build: () => DummyListBloc(_mockDummyDataUseCase),
      act: (bloc) {
        bloc.add(FetchDummyListData());
      },
      expect: () => [const DummyListLoaded(tDummyList)],
    );

    blocTest<DummyListBloc, DummyListState>(
      'Should return DummyListFailure when _mockDummyDataUseCase is called ',
      build: () => DummyListBloc(_mockDummyDataUseCase),
      act: (bloc) {
        bloc.add(FetchDummyListData());
      },
      expect: () => [isA<DummyListFailure>()],
    );
  });
}
