import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petperfect/presentation/features/screen1/bloc/image_bloc.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            _ImageWidget(),
          ],
        ),
      ),
      floatingActionButton: const _FloatActionButton(),
    );
  }
}

class _ImageWidget extends StatelessWidget {
  const _ImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageBloc, ImageState>(
      bloc: context.read<ImageBloc>()..add(GetImageUrl()),
      builder: (context, state) {
        if (state is ImageLoaded) {
          return Image.network(state.imageUrl);
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
  Widget build(BuildContext context) {
    return BlocBuilder<ImageBloc, ImageState>(
      builder: (context, state) {
        // If Image is Loaded, Show Floating Action button
        if (state is ImageLoaded) {
          return FloatingActionButton(onPressed: () {
            context.read<ImageBloc>().add(SaveImageUrl(state.imageUrl));
            // Navigator.push(context, MaterialPageRoute(builder: => {}))
          });
        }

        // Return Container
        return Container();
      },
    );
  }
}
