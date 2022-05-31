import 'package:equatable/equatable.dart';

// Base Use Case, Every Use case will extend this Case
// It will expose execute method to call
abstract class BaseUseCase<Result, Params> {
  Future<Result> execute(Params params);
}

// For method where no param is needed to passed
// Use this instead of void
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
