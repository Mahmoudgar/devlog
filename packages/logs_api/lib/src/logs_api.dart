import 'package:logs_api/logs_api.dart';

abstract class LogsApi {
  const LogsApi();

  Stream<List<Project>> getProjects();

  Future<void> saveProject(Project project);

  Future<void> deleteProject(String id);

  Stream<List<Log>> getLogs(Project project);

  Future<void> saveLog(Project project, Log log);

  Future<void> deleteLog(Project project, String id);


}

class ProjectNotFoundException implements Exception {}

class LogNotFoundException implements Exception {}
