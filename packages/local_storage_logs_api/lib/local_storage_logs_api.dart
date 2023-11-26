import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logs_api/logs_api.dart';

/// {@template local_storage_todos_api}
/// A Flutter implementation of the [LogsApi] that uses local storage.
/// {@endtemplate}
class LocalStorageLogsApi extends LogsApi {
  /// {@macro local_storage_todos_api}
  LocalStorageLogsApi({
    required SharedPreferences plugin,
  }) : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;

  final _projectStreamController =
      BehaviorSubject<List<Project>>.seeded(const []);

  /// The key used for storing the todos locally.
  ///
  /// This is only exposed for testing and shouldn't be used by consumers of
  /// this library.
  @visibleForTesting
  static const kLogsCollectionKey = '__todos_collection_key__';

  String? _getValue(String key) => _plugin.getString(key);
  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  void _init() {
    final projectsJson = _getValue(kLogsCollectionKey);
    if (projectsJson != null) {
      final projects = List<Map<String, dynamic>>.from(
        json.decode(projectsJson) as List,
      ).map((jsonMap) => Project.fromMap(jsonMap)).toList();
      _projectStreamController.add(projects);
    } else {
      _projectStreamController.add(const []);
    }
  }

  @override
  Stream<List<Project>> getProjects() =>
      _projectStreamController.asBroadcastStream();

  @override
  Future<void> saveProject(Project project) {
    final projects = [..._projectStreamController.value];
    final projectIndex = projects.indexWhere((t) => t.id == project.id);
    if (projectIndex >= 0) {
      projects[projectIndex] = project;
    } else {
      projects.add(project);
    }

    _projectStreamController.add(projects);
    return _setValue(kLogsCollectionKey, json.encode(projects));
  }

  @override
  Future<void> deleteProject(String id) async {
    final projects = [..._projectStreamController.value];
    final projectIndex = projects.indexWhere((t) => t.id == id);
    if (projectIndex == -1) {
      throw ProjectNotFoundException();
    } else {
      projects.removeAt(projectIndex);
      _projectStreamController.add(projects);
      return _setValue(kLogsCollectionKey, json.encode(projects));
    }
  }

  @override
  Future<void> deleteLog(Project project, String id) {
    final projects = [..._projectStreamController.value];
    final projectIndex = projects.indexWhere((t) => t.id == project.id);
    if (projectIndex == -1) {
      throw ProjectNotFoundException();
    } else {
      final logIndex =
          projects[projectIndex].logs.indexWhere((t) => t.id == id);
      if (logIndex == -1) {
        throw LogNotFoundException();
      } else {
        projects[projectIndex].logs.removeAt(logIndex);
        _projectStreamController.add(projects);
        return _setValue(kLogsCollectionKey, json.encode(projects));
      }
    }
  }

  @override
  Stream<List<Log>> getLogs(Project project) async* {
    await for (final value in _projectStreamController.stream) {
      final projectIndex = value.indexWhere((t) => t.id == project.id);
      if (projectIndex == -1) {
        throw ProjectNotFoundException();
      } else {
        yield value[projectIndex].logs;
      }
    }
  }

  @override
  Future<void> saveLog(Project project, Log log) {
     final projects = [..._projectStreamController.value];
    final projectIndex = projects.indexWhere((t) => t.id == project.id);
     final logIndex =
          projects[projectIndex].logs.indexWhere((t) => t.id == log.id);
    if (logIndex >= 0) {
      projects[projectIndex].logs[logIndex] = log;
    } else {
      projects[projectIndex].logs.add(log);
    }

    _projectStreamController.add(projects);
    return _setValue(kLogsCollectionKey, json.encode(projects));
  }
}
