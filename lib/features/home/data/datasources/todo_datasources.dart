import 'package:either_dart/either.dart';
import 'package:todolist/core/failure/failure.dart';

abstract class TodoDataSources {
  Future<Either<Failure, List>> addToDo(String todo);
  Future<Either<Failure, List>> removeToDo(int hashCode);
  Future<Either<Failure, List>> getTodo();
}
