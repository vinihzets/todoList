import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todolist/core/architeture/bloc_screen_builder.dart';
import 'package:todolist/core/architeture/bloc_state.dart';
import 'package:todolist/features/home/presentation/bloc/home_bloc.dart';
import 'package:todolist/features/home/presentation/bloc/home_event.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc bloc;

  final todoController = TextEditingController();

  @override
  void initState() {
    bloc = GetIt.I.get();

    bloc.event.add(HomeEventGetTodo());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocScreenBuilder(
          stream: bloc.state,
          builder: (state) {
            if (state is BlocStableState) {
              final List list = state.data;
              return _buildTodoListView(list, bloc);
            } else {
              return Container();
            }
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _buildNewTodoDialog(context, bloc, todoController);
        },
        label: const Text('+ Adicionar'),
      ),
    );
  }
}

_buildTodoListView(List list, HomeBloc bloc) {
  return ListView.separated(
      itemBuilder: (context, index) {
        return Column(
          children: list
              .map((e) => ListTile(
                    leading: Text(e),
                    onTap: () =>
                        bloc.dispatchEvent(HomeEventRemoveTodo(e.hashCode)),
                  ))
              .toList(),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemCount: 1);
}

_buildNewTodoDialog(
    BuildContext context, HomeBloc bloc, TextEditingController controller) {
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Column(
            children: [
              SizedBox(
                width: 150,
                child: TextField(
                  controller: controller,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    bloc.dispatchEvent(
                        HomeEventAddTodo(context, controller.text));
                  },
                  child: Text('Adicionar Nova Tarefa'))
            ],
          ),
        );
      });
}
