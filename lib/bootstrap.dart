import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:devlog/app/app.dart';
import 'package:flutter/widgets.dart';
import 'package:logs_api/logs_api.dart';
import 'package:logs_repository/logs_repository.dart';

import 'app/app_bloc_observer.dart';

void bootstrap({required LogsApi logsAPi}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  Bloc.observer = const AppBlocObserver();
  final logsRepository = LogsRepository(logsApi: logsAPi);
  runZonedGuarded(
    () => runApp(App(logsRepository: logsRepository)),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );



}
