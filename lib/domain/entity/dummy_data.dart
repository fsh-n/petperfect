import 'package:equatable/equatable.dart';

class DummyData extends Equatable {
  final String title;
  final String body;

  const DummyData(this.title, this.body);

  @override
  List<Object> get props => [title, body];
}
