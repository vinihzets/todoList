import 'package:either_dart/either.dart';
import 'package:todolist/core/failure/failure.dart';
import 'package:todolist/features/home/domain/repositories/todo_repository.dart';
import 'package:todolist/features/home/domain/usecases/add_todo_usecase.dart';

class AddTodoUseCaseImp implements AddTodoUseCase {
  TodoRepository toDoRepository;

  AddTodoUseCaseImp(this.toDoRepository);

  Future<Either<Failure, List>> addToDo(String todo) {
    return toDoRepository.addToDo(todo);
  }
}
