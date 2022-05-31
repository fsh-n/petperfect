part of 'dummy_list_bloc.dart';

abstract class DummyListEvent extends Equatable {
  const DummyListEvent();

  @override
  List<Object> get props => [];
}

class FetchDummyListData extends DummyListEvent {}
