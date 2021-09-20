import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:epicture/core/presentation/app/app.dart';
import 'package:epicture/core/presentation/app/app_bloc_observer.dart';
import 'package:epicture/core/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  runZonedGuarded(
    () => runApp(BlocProvider(
      create: (context) => UserBloc(),
      child: App(),
    )),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
