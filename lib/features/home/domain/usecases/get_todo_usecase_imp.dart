import 'package:either_dart/either.dart';
import 'package:todolist/core/failure/failure.dart';
import 'package:todolist/features/home/domain/repositories/todo_repository.dart';
import 'package:todolist/features/home/domain/usecases/get_todo_usecase.dart';

class GetTodoUseCaseImp implements GetTodoUseCase {
  TodoRepository repository;

  GetTodoUseCaseImp(this.repository);

  Future<Either<Failure, List>> getTodo() {
    return repository.getTodo();
  }
}
