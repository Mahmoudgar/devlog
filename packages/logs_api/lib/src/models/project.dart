// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:logs_api/logs_api.dart';
import 'package:uuid/uuid.dart';

class Project extends Equatable {
  Project({required this.title, String? id, this.logs = const []})
      : assert(
          id == null || id.isNotEmpty,
          'id must either be null or not empty',
        ),
        id = id ?? const Uuid().v4();

  final String id;

  final List<Log> logs;

  final String title;

  @override
  List<Object> get props => [id, title, logs];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'logs': logs.map((x) => x.toMap()).toList(),
      'title': title,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'] as String,
      logs: List<Log>.from(
        (map['logs'] as List<int>).map<Log>(
          (x) => Log.fromMap(x as Map<String, dynamic>),
        ),
      ),
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Project.fromJson(String source) =>
      Project.fromMap(json.decode(source) as Map<String, dynamic>);

  Project copyWith({
    String? id,
    List<Log>? logs,
    String? title,
  }) {
    return Project(
      id: id ?? this.id,
      logs: logs ?? this.logs,
      title: title ?? this.title,
    );
  }
}
