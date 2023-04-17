import 'package:either_dart/either.dart';
import 'package:todolist/core/failure/failure.dart';
import 'package:todolist/features/home/data/datasources/todo_datasources.dart';
import 'package:todolist/features/home/domain/repositories/todo_repository.dart';

class TodoRepositoryImp implements TodoRepository {
  TodoDataSources todoDataSources;

  TodoRepositoryImp(this.todoDataSources);

  @override
  Future<Either<Failure, List>> addToDo(String todo) {
    return todoDataSources.addToDo(todo);
  }

  @override
  Future<Either<Failure, List>> removeToDo(int hashCode) {
    return todoDataSources.removeToDo(hashCode);
  }

  @override
  Future<Either<Failure, List>> getTodo() {
    return todoDataSources.getTodo();
  }
}
