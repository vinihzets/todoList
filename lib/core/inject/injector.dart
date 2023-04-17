import 'package:get_it/get_it.dart';
import 'package:todolist/core/consts/consts.dart';

class Inject {
  static injector() {
    GetIt getIt = GetIt.instance;

    //core
    getIt.registerLazySingleton(() => Consts());

    //datasources

    //repositories

    //usecases

    // bloc
  }
}
