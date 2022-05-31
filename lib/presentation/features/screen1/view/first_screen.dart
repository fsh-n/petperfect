import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/repository/dummy_data_repo.dart';
import '../../../../domain/usecase/get_dummy_data_use_case.dart';
import '../../screen2/bloc/dummy_list_bloc.dart';
import '../../screen2/view/second_screen.dart';
import '../bloc/image_bloc.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'First Screen',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
      body: const _ImageWidget(),
      floatingActionButton: const _FloatActionButton(),
    );
  }
}

class _ImageWidget extends StatelessWidget {
  const _ImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<ImageBloc, ImageState>(
      bloc: context.read<ImageBloc>()..add(GetImageUrl()),
      builder: (context, state) {
        if (state is ImageLoaded) {
          return Center(
            child: Container(
                alignment: Alignment.center,
                child: Image.network(
                  state.imageUrl,
                  // loadingBuilder: (context, child, loadingProgress) =>
                  //     const CircularProgressIndicator(),
                  height: size.height / 2,
                  width: size.width,
                )),
          );
        }

        if (state is ImageFailure) {
          return const Center(
            child: Text(
              'Failed to load image',
              style: TextStyle(fontSize: 24),
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class _FloatActionButton extends StatelessWidget {
  const _FloatActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext buildContext) {
    return BlocBuilder<ImageBloc, ImageState>(
      builder: (context, state) {
        // If Image is Loaded, Show Floating Action button
        if (state is ImageLoaded) {
          return FloatingActionButton(
              child: const Padding(
                padding: EdgeInsets.fromLTRB(4.0, 0.0, 0.0, 0.0),
                child: Icon(Icons.arrow_forward_ios),
              ),
              onPressed: () {
                context.read<ImageBloc>().add(SaveImageUrl(state.imageUrl));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider(
                              create: (context) => DummyListBloc(
                                  GetDummyDataUseCaseImpl(buildContext
                                      .read<DummyDataRepository>())),
                              child: const SecondScreen(),
                            )));
              });
        }

        // Return Container
        return Container();
      },
    );
  }
}
