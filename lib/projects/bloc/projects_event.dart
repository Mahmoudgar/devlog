part of 'projects_bloc.dart';

sealed class ProjectsEvent extends Equatable {
  const ProjectsEvent();

  @override
  List<Object> get props => [];

}


final class ProjectsProjectDeleted extends ProjectsEvent {
  const ProjectsProjectDeleted(this.project);

  final Project project;

  @override
  List<Object> get props => [project];
}

final class ProjectsProjectCreated extends ProjectsEvent {
  const ProjectsProjectCreated(this.project);

  final Project project;

  @override
  List<Object> get props => [project];
}

final class ProjectsUndoDeletionRequested extends ProjectsEvent {
  const ProjectsUndoDeletionRequested();
}