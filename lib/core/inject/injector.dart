import 'package:get_it/get_it.dart';
import 'package:todolist/core/consts/consts.dart';
import 'package:todolist/features/home/data/datasources/local/todo_datasources_local_imp.dart';
import 'package:todolist/features/home/data/datasources/todo_datasources.dart';
import 'package:todolist/features/home/data/repositories/todo_repository_imp.dart';
import 'package:todolist/features/home/domain/repositories/todo_repository.dart';
import 'package:todolist/features/home/domain/usecases/add_todo_usecase.dart';
import 'package:todolist/features/home/domain/usecases/add_todo_usecase_imp.dart';
import 'package:todolist/features/home/domain/usecases/get_todo_usecase.dart';
import 'package:todolist/features/home/domain/usecases/get_todo_usecase_imp.dart';
import 'package:todolist/features/home/domain/usecases/remove_todo_usecase.dart';
import 'package:todolist/features/home/domain/usecases/remove_todo_usecase_imp.dart';
import 'package:todolist/features/home/presentation/bloc/home_bloc.dart';

class Inject {
  static injector() {
    GetIt getIt = GetIt.instance;

    //core
    getIt.registerLazySingleton(() => Consts());

    //datasources

    getIt.registerLazySingleton<TodoDataSources>(
        () => TodoDataSourcesLocalImp());

    //repositories

    getIt.registerLazySingleton<TodoRepository>(
        () => TodoRepositoryImp(getIt()));

    //usecases

    getIt.registerLazySingleton<RemoveTodoUseCase>(
        () => RemoveTodoUseCaseImp(getIt()));

    getIt.registerLazySingleton<GetTodoUseCase>(
        () => GetTodoUseCaseImp(getIt()));

    getIt.registerLazySingleton<AddTodoUseCase>(
        () => AddTodoUseCaseImp(getIt()));

    // bloc

    getIt.registerFactory(() => HomeBloc(
          getIt(),
          getIt(),
          getIt(),
        ));
  }
}
