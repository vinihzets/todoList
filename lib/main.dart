import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todolist/core/consts/consts.dart';
import 'package:todolist/core/inject/injector.dart';
import 'package:todolist/features/home/presentation/ui/home_screen.dart';

void main() async {
  await Inject.injector();

  Consts constsRoutes = GetIt.I.get();

  runApp(MaterialApp(
    initialRoute: constsRoutes.homeScreen,
    routes: {
      constsRoutes.homeScreen: (_) => const HomeScreen(),
    },
  ));
}
