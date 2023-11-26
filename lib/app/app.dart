import 'package:devlog/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logs_repository/logs_repository.dart';

class App extends StatelessWidget {
  const App({required this.logsRepository, super.key});

  final LogsRepository logsRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: logsRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FlutterLogsTheme.light,
      darkTheme: FlutterLogsTheme.dark,
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      // supportedLocales: AppLocalizations.supportedLocales,
      home: const HomePage(),
    );
  }
}