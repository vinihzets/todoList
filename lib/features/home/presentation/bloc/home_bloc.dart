import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:todolist/core/architeture/bloc_state.dart';
import 'package:todolist/core/consts/hud_mixins.dart';
import 'package:todolist/features/home/domain/usecases/add_todo_usecase.dart';
import 'package:todolist/features/home/domain/usecases/get_todo_usecase.dart';
import 'package:todolist/features/home/domain/usecases/remove_todo_usecase.dart';
import 'package:todolist/features/home/presentation/bloc/home_event.dart';

class HomeBloc with HudMixins {
  AddTodoUseCase addTodoUseCase;
  GetTodoUseCase getTodoUseCase;
  RemoveTodoUseCase removeTodoUseCase;

  late List _cache;

  late StreamController<HomeEvent> _event;
  Sink<HomeEvent> get event => _event.sink;

  late StreamController<BlocState> _state;
  Stream<BlocState> get state => _state.stream;

  HomeBloc(
    this.addTodoUseCase,
    this.getTodoUseCase,
    this.removeTodoUseCase,
  ) {
    _event = StreamController.broadcast();

    _state = StreamController.broadcast();

    _cache = [];

    _event.stream.listen(_mapListenEvent);
  }

  dispatchEvent(HomeEvent event) {
    _event.add(event);
  }

  dispatchState(BlocState state) {
    _state.add(state);
  }

  _mapListenEvent(HomeEvent event) {
    if (event is HomeEventGetTodo) {
      getTodo();
    } else if (event is HomeEventAddTodo) {
      addToDo(event.context, event.todo);
    } else if (event is HomeEventRemoveTodo) {
      removeToDo(event.code);
    }
  }

  addToDo(BuildContext context, String todo) async {
    final addRequest = await addTodoUseCase.addToDo(todo);

    addRequest.fold((left) {
      dispatchState(BlocErrorState(message: left.message));
    }, (right) {
      navigatePop(context);
      dispatchState(BlocStableState(data: right));
    });
  }

  getTodo() async {
    final getRequest = await getTodoUseCase.getTodo();

    getRequest.fold((left) {
      dispatchState(BlocErrorState(message: left.message));
    }, (right) {
      _cache = right;

      if (_cache.isNotEmpty) {
        dispatchState(BlocStableState(data: right));
      } else if (_cache.isEmpty) {
        dispatchState(BlocEmptyState());
      }
    });
  }

  removeToDo(int hashCode) async {
    final todoRequest = await removeTodoUseCase.removeTodo(hashCode);
    todoRequest.fold((left) {
      dispatchState(BlocErrorState(message: left.message));
    }, (right) {
      _cache = right;
      if (_cache.isNotEmpty) {
        dispatchState(BlocStableState(data: right));
      } else if (_cache.isEmpty) {
        dispatchState(BlocEmptyState());
      }
    });
  }
}
