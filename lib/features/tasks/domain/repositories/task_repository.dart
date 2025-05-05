import 'package:fpdart/fpdart.dart';
import 'package:taskify/core/error/failures.dart';
import 'package:taskify/features/tasks/domain/entities/task.dart';

abstract interface class TaskRepository {
  Either<Failure, List<Tasks>> getAllTasks();

  Either<Failure, void> addTask(Tasks task);

  Either<Failure, void> updateTask(Tasks task);

  Either<Failure, void> deleteTask(String id);

  Either<Failure, List<Tasks>> getFilteredTasks(String status);
}
