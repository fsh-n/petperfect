import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petperfect/domain/usecase/base_use_case.dart';
import 'package:petperfect/domain/usecase/get_image_url_use_case.dart';
import 'package:petperfect/domain/usecase/save_image_url_use_case.dart';

part 'image_event.dart';
part 'image_state.dart';

//Image Bloc will only depend upon use case in order to get the data
class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc(this.getImageUrlUseCase, this.saveImageUrlUseCase)
      : super(ImageInitial()) {
    on<GetImageUrl>(_getImageUrl);
    on<SaveImageUrl>(_saveImageUrl);
  }

  final GetImageUrlUseCase getImageUrlUseCase;
  final SaveImageUrlUseCase saveImageUrlUseCase;

  FutureOr<void> _getImageUrl(
      GetImageUrl event, Emitter<ImageState> emit) async {
    try {
      final result = await getImageUrlUseCase.execute(NoParams());
      emit(ImageLoaded(imageUrl: result));
    } catch (_) {
      emit(ImageFailure());
    }
  }

  FutureOr<void> _saveImageUrl(
      SaveImageUrl event, Emitter<ImageState> emit) async {
    try {
      await saveImageUrlUseCase.execute(event.imageUrl);
    } catch (ex) {
      // Log exception
    }
  }
}
