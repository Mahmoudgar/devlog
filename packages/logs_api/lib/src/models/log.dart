// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Log extends Equatable {
  Log({required this.title, String? id, this.story = ''})
      : assert(
          id == null || id.isNotEmpty,
          'id must either be null or not empty',
        ),
        id = id ?? const Uuid().v4();

  final String id;

  final String title;

  final String story;

  @override
  List<Object> get props => [id, title, story];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'story': story,
    };
  }

  factory Log.fromMap(Map<String, dynamic> map) {
    return Log(
      id: map['id'] as String,
      title: map['title'] as String,
      story: map['story'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Log.fromJson(String source) => Log.fromMap(json.decode(source) as Map<String, dynamic>);

  Log copyWith({
    String? id,
    String? title,
    String? story,
  }) {
    return Log(
      id: id ?? this.id,
      title: title ?? this.title,
      story: story ?? this.story,
    );
  }
}
