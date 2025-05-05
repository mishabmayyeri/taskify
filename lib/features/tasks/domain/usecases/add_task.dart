import 'package:fpdart/fpdart.dart';
import 'package:taskify/core/error/failures.dart';
import 'package:taskify/core/usecase/usecase.dart';
import 'package:taskify/features/tasks/domain/entities/task.dart';
import 'package:taskify/features/tasks/domain/repositories/task_repository.dart';

class AddTask implements UseCase<void, TaskParams> {
  final TaskRepository repository;

  AddTask(this.repository);

  @override
  Either<Failure, void> call(TaskParams params) {
    final task = Tasks(
      id: params.id,
      title: params.title,
      description: params.description,
      priority: params.priority,
      status: params.status,
      dueDate: params.dueDate,
      createdAt: params.createdAt,
      updatedAt: params.updatedAt,
    );

    return repository.addTask(task);
  }
}

class TaskParams {
  final String id;
  final String title;
  final String description;
  final String priority;
  final String status;
  final DateTime dueDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  TaskParams({
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
