import 'dart:developer';

import 'package:todolist/core/failure/failure.dart';
import 'package:either_dart/src/either.dart';
import 'package:todolist/features/home/data/datasources/todo_datasources.dart';

class TodoDataSourcesLocalImp implements TodoDataSources {
  final todoList = [];

  @override
  Future<Either<Failure, List>> addToDo(String todo) async {
    try {
      final addToList = todoList.add(todo);

      return Right(todoList);
    } on Failure catch (e) {
      return Left(RemoteFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List>> removeToDo(int hashCode) async {
    try {
      todoList.removeWhere((item) => item.hashCode == hashCode);

      return Right(todoList);
    } on Failure catch (e) {
      return Left(RemoteFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List>> getTodo() async {
    try {
      if (todoList.isNotEmpty) {
        return Right(todoList);
      } else {
        return const Right([]);
      }
    } on Failure catch (e) {
      return Left(RemoteFailure(message: e.message));
    }
  }
}
