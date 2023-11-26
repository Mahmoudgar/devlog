import 'package:logs_api/logs_api.dart';

class LogsRepository {
  const LogsRepository({
    required LogsApi logsApi,
  }) : _logsApi = logsApi;

  final LogsApi _logsApi;

  Stream<List<Project>> getProjects() => _logsApi.getProjects();

  Future<void> saveProject(Project project) => _logsApi.saveProject(project);

  Future<void> deleteProject(String id) => _logsApi.deleteProject(id);

  Stream<List<Log>> getLogs(Project project) => _logsApi.getLogs(project);

  Future<void> saveLog(Project project, Log log) =>
      _logsApi.saveLog(project, log);

  Future<void> deleteLog(Project project, String id) =>
      _logsApi.deleteLog(project, id);
}
