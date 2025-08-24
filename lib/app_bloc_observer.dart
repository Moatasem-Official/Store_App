import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint(change.toString());
    print('Change: ${bloc.runtimeType} $change');
  }

  @override
  void onClose(BlocBase bloc) {
    debugPrint(bloc.runtimeType.toString());
    print('Close: ${bloc.runtimeType} $bloc');
  }

  @override
  void onCreate(BlocBase bloc) {
    debugPrint(bloc.runtimeType.toString());
    print('Create: ${bloc.runtimeType} $bloc');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint(error.toString());
    print('Error: ${bloc.runtimeType} $error');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    debugPrint(transition.toString());
    print('Transition: ${bloc.runtimeType} $transition');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {}
}
