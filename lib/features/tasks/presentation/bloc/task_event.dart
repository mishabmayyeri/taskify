part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

class GetAllTasksEvent extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final String id;
  final String title;
  final String description;
  final String priority;
  final String status;
  final DateTime dueDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  AddTaskEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.dueDate,
    required this.createdAt,
    required this.updatedAt,
  });
}

class UpdateTaskEvent extends TaskEvent {
  final String id;
  final String title;
  final String description;
  final String priority;
  final String status;
  final DateTime dueDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  UpdateTaskEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.dueDate,
    required this.createdAt,
    required this.updatedAt,
  });
}

class DeleteTaskEvent extends TaskEvent {
  final String id;

  DeleteTaskEvent(this.id);
}

class FilterTasksEvent extends TaskEvent {
  final String status;

  FilterTasksEvent(this.status);
}
