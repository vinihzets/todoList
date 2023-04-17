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
            } else if (state is BlocEmptyState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.close_sharp,
                      size: 60,
                    ),
                    Text(
                      'Nenhuma tarefa registrada ainda',
                      style: TextStyle(fontSize: 24),
                    )
                  ],
                ),
              );
            } else {
              return const SizedBox.shrink();
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
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 150,
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                      hintText: 'Sua nova tarefa',
                      hintStyle: TextStyle(color: Colors.white)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                    onPressed: () {
                      bloc.dispatchEvent(
                          HomeEventAddTodo(context, controller.text));
                      controller.text = '';
                    },
                    child: const Text(
                      'Adicionar Nova Tarefa',
                      style: TextStyle(color: Colors.black),
                    )),
              )
            ],
          ),
        );
      });
}
