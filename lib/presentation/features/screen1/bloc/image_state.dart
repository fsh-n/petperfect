part of 'image_bloc.dart';

abstract class ImageState extends Equatable {
  @override
  List<Object> get props => [];
}

class ImageInitial extends ImageState {}

class ImageLoaded extends ImageState {
  final String imageUrl;

  ImageLoaded({required this.imageUrl});

  @override
  List<Object> get props => [];
}

class ImageFailure extends ImageState {}
