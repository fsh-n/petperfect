import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petperfect/data/model/DummyDataModel.dart';
import 'package:petperfect/domain/usecase/base_use_case.dart';
import 'package:petperfect/domain/usecase/get_dummy_data_use_case.dart';

part 'dummy_list_event.dart';
part 'dummy_list_state.dart';

class DummyListBloc extends Bloc<DummyListEvent, DummyListState> {
  DummyListBloc(this.getDummyDataUseCase) : super(DummyListInitial()) {
    on<FetchDummyListData>(_fetchDummyListData);
  }

  final GetDummyDataUseCase getDummyDataUseCase;

  FutureOr<void> _fetchDummyListData(
      FetchDummyListData event, Emitter<DummyListState> emit) async {
    try {
      final result = await getDummyDataUseCase.execute(NoParams());
      emit(DummyListLoaded(result));
    } catch (ex) {
      emit(DummyListFailure());
    }
  }
}
