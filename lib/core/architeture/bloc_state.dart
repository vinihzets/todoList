abstract class BlocState<T> {
  T? data;

  BlocState({required this.data});
}

class BlocStableState extends BlocState {
  BlocStableState({super.data});
}

class BlocIdleState extends BlocState {
  BlocIdleState({super.data});
}

class BlocErrorState extends BlocState {
  final String? message;

  BlocErrorState({super.data, this.message});
}

class BlocLoadingState extends BlocState {
  BlocLoadingState({super.data});
}

class BlocEmptyState extends BlocState {
  BlocEmptyState({super.data});
}
