import 'package:fpdart/fpdart.dart';
import 'package:taskify/core/error/failures.dart';
import 'package:taskify/core/usecase/usecase.dart';
import 'package:taskify/features/tasks/domain/entities/task.dart';
import 'package:taskify/features/tasks/domain/repositories/task_repository.dart';
import 'package:taskify/features/tasks/domain/usecases/add_task.dart';

class UpdateTask implements UseCase<void, TaskParams> {
  final TaskRepository repository;

  UpdateTask(this.repository);

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

    return repository.updateTask(task);
  }
}
