import 'package:flutter/material.dart';
import 'package:todolist/core/architeture/bloc_state.dart';

class BlocScreenBuilder extends StatelessWidget {
  final Stream stream;
  final Widget Function(BlocState) onStable;
  final Widget Function(BlocState) onLoading;
  final Widget Function(BlocState) onError;
  final Widget Function(BlocState) onEmpty;
  const BlocScreenBuilder(
      {super.key, required this.stream, required this.onStable,
       required this.onLoading, 
       required this.onEmpty,
        required this.onError
       });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: stream,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return _buildState(snapshot.data);
          } else {
            return const SizedBox.shrink();
          }
        }));
  }


  _buildState(BlocState state){
    if(state is BlocStableState){
      return onStable(state);
    } else if(state is BlocEmptyState){
      return onEmpty(state);
    }
     else if(state is BlocLoadingState){
      return onLoading(state);
    } 
    else if(state is BlocErrorState){
      return onError(state);
    }
  }
}
