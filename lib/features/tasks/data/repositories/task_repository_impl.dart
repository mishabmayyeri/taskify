import 'package:fpdart/fpdart.dart';
import 'package:taskify/core/error/exceptions.dart';
import 'package:taskify/core/error/failures.dart';
import 'package:taskify/features/tasks/data/datasources/task_local_data_source.dart';
import 'package:taskify/features/tasks/data/models/task_model.dart';
import 'package:taskify/features/tasks/domain/entities/task.dart';
import 'package:taskify/features/tasks/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl({required this.localDataSource});

  @override
  Either<Failure, List<Tasks>> getAllTasks() {
    try {
      final taskModels = localDataSource.getAllTasks();
      final tasks = taskModels.map((model) => model as Tasks).toList();
      return Right(tasks);
    } on LocalException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Either<Failure, void> addTask(Tasks task) {
    try {
      final taskModel = TaskModel(
        id: task.id,
        title: task.title,
        description: task.description,
        priority: task.priority,
        status: task.status,
        dueDate: task.dueDate,
        createdAt: task.createdAt,
        updatedAt: task.updatedAt,
      );
      localDataSource.addTask(taskModel);
      return const Right(null);
    } on LocalException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Either<Failure, void> updateTask(Tasks task) {
    try {
      final taskModel = TaskModel(
        id: task.id,
        title: task.title,
        description: task.description,
        priority: task.priority,
        status: task.status,
        dueDate: task.dueDate,
        createdAt: task.createdAt,
        updatedAt: task.updatedAt,
      );
      localDataSource.updateTask(taskModel);
      return const Right(null);
    } on LocalException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Either<Failure, void> deleteTask(String id) {
    try {
      localDataSource.deleteTask(id);
      return const Right(null);
    } on LocalException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Either<Failure, List<Tasks>> getFilteredTasks(String status) {
    try {
      final taskModels = localDataSource.getFilteredTasks(status);
      final tasks = taskModels.map((model) => model as Tasks).toList();
      return Right(tasks);
    } on LocalException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure('Unexpected error: ${e.toString()}'));
    }
  }
}
