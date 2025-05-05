part of 'task_bloc.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Tasks> tasks;

  TaskLoaded(this.tasks);
}

class TaskOperationSuccess extends TaskState {
  final String message;

  TaskOperationSuccess(this.message);
}

class TaskError extends TaskState {
  final String message;

  TaskError(this.message);
}
