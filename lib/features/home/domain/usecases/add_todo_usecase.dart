import 'package:either_dart/either.dart';
import 'package:todolist/core/failure/failure.dart';

abstract class AddTodoUseCase {
  Future<Either<Failure, List>> addToDo(String todo);
}
