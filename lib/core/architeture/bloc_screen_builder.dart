import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:todolist/core/architeture/bloc_state.dart';

class BlocScreenBuilder extends StatelessWidget {
  final Stream stream;
  final Widget Function(BlocState) builder;
  const BlocScreenBuilder(
      {super.key, required this.stream, required this.builder});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: stream,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return builder(snapshot.data);
          } else {
            return SizedBox.shrink();
          }
        }));
  }
}
