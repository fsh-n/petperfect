import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petperfect/presentation/features/screen2/bloc/dummy_list_bloc.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _DummyList(),
    );
  }
}

class _DummyList extends StatelessWidget {
  const _DummyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DummyListBloc, DummyListState>(
        bloc: context.read<DummyListBloc>()..add(FetchDummyListData()),
        builder: (context, state) {
          //Default Circular progress indicator
          if (state is! DummyListLoaded) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Get Subscription History
          if (state is DummyListFailure) {
            return const Center(
              child: Text('Failed to get list', style: TextStyle(fontSize: 24)),
            );
          }

          // Dummy List
          final dummyList = state.dummyData;

          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  dummyList[index].title,
                ),
                subtitle: Text(dummyList[index].body),
              );
            },
            itemCount: state.dummyData.length,
          );
        });
  }
}
