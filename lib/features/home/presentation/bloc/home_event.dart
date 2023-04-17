import 'package:flutter/cupertino.dart';

abstract class HomeEvent {}

class HomeEventGetTodo implements HomeEvent {}

class HomeEventAddTodo implements HomeEvent {
  BuildContext context;
  String todo;

  HomeEventAddTodo(this.context, this.todo);
}

class HomeEventRemoveTodo implements HomeEvent {
  int code;

  HomeEventRemoveTodo(this.code);
}
