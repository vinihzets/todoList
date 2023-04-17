import 'package:either_dart/either.dart';
import 'package:todolist/core/failure/failure.dart';
import 'package:todolist/features/home/domain/repositories/todo_repository.dart';
import 'package:todolist/features/home/domain/usecases/remove_todo_usecase.dart';

class RemoveTodoUseCaseImp implements RemoveTodoUseCase {
  TodoRepository todoRepository;

  RemoveTodoUseCaseImp(this.todoRepository);

  @override
  Future<Either<Failure, List>> removeTodo(int hashCode) {
    return todoRepository.removeToDo(hashCode);
  }
}
