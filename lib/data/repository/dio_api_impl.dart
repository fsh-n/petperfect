import 'package:dio/dio.dart';
import 'package:petperfect/data/repository/abstract/api.dart';

import '../model/DummyDataModel.dart';

class DioApiImpl implements Api {
  late final dio = createDio();

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      receiveTimeout: 15000, // 15 seconds
      connectTimeout: 15000,
      sendTimeout: 15000,
    ));

    dio.interceptors.addAll({
      AppInterceptors(dio),
    });
    return dio;
  }

  @override
  Future<List<DummyDataModel>> fetchDummyData() async {
    try {
      var response =
          await Dio().get('http://jsonplaceholder.typicode.com/posts');
      final data = response.data;
      var dummyList = <DummyDataModel>[];
      if (data != null) {
        data.forEach((v) {
          dummyList.add(DummyDataModel.fromJson(v));
        });
      }
      return dummyList;
    } catch (e) {
      // Log Exception to send to server for analytics
      print(e);
      // Rethrow
      rethrow;
    }
  }

  @override
  Future<String> fetchImageUrl() async {
    try {
      var response = await Dio().get('https://random.dog/woof.json');
      final data = response.data;
      String url = data['url'];
      if (url.endsWith('.jpg') || url.endsWith('.jpeg')) {
        return url;
      }
      // If it is not an image return hard code image
      return 'https://random.dog/a338fdf7-70aa-4a26-a2c2-357cdede7991.jpg';
    } catch (e) {
      // Log Exception to send to server for analytcs
      print(e);
      // Rethrow
      rethrow;
    }
  }
}

class AppInterceptors extends Interceptor {
  final Dio dio;

  AppInterceptors(this.dio);

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioErrorType.response:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions);
          case 401:
            throw UnauthorizedException(err.requestOptions);
          case 404:
            throw NotFoundException(err.requestOptions);
          case 409:
            throw ConflictException(err.requestOptions);
          case 500:
            throw InternalServerErrorException(err.requestOptions);
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        throw NoInternetConnectionException(err.requestOptions);
    }

    return handler.next(err);
  }
}

class BadRequestException extends DioError {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class ConflictException extends DioError {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioError {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends DioError {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}
