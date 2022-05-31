import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:petperfect/domain/repository/image_repository.dart';

import 'data/repository/abstract/api.dart';
import 'data/repository/dio_api_impl.dart';
import 'data/repository/dummy_data_repo_impl.dart';
import 'data/repository/image_repository_impl.dart';
import 'domain/repository/dummy_data_repo.dart';
import 'domain/usecase/get_image_url_use_case.dart';
import 'domain/usecase/save_image_url_use_case.dart';
import 'presentation/features/screen1/bloc/image_bloc.dart';
import 'presentation/features/screen1/view/first_screen.dart';

void main() async {
  await Hive.initFlutter();
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider<Api>(
        create: (context) => DioApiImpl(),
      ),
      RepositoryProvider<DummyDataRepository>(
        create: (context) => DummyDataRepositoryImpl(context.read<Api>()),
      ),
      RepositoryProvider<ImageRepository>(
        create: (context) => ImageRepositoryImpl(context.read<Api>()),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => ImageBloc(
            GetImageUrlUseCaseImpl(context.read<ImageRepository>()),
            SaveImageUrlUseCaseImpl(context.read<ImageRepository>())),
        child: const FirstScreen(),
      ),
    );
  }
}
