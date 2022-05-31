part of 'image_bloc.dart';

abstract class ImageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetImageUrl extends ImageEvent {}

class SaveImageUrl extends ImageEvent {
  final String imageUrl;

  SaveImageUrl(this.imageUrl);

  @override
  List<Object> get props => [imageUrl];
}
