import 'package:either_dart/either.dart';
import 'package:todolist/core/failure/failure.dart';

abstract class RemoveTodoUseCase {
  Future<Either<Failure, List>> removeTodo(int hashCode);
}
