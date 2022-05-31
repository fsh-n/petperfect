part of 'dummy_list_bloc.dart';

abstract class DummyListState extends Equatable {
  const DummyListState();

  @override
  List<Object> get props => [];
}

class DummyListInitial extends DummyListState {}

class DummyListLoaded extends DummyListState {
  final List<DummyDataModel> dummyData;

  const DummyListLoaded(this.dummyData);

  @override
  List<Object> get props => [dummyData];
}

class DummyListFailure extends DummyListState {}
