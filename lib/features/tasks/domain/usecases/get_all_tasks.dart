import 'package:fpdart/fpdart.dart';
import 'package:taskify/core/error/failures.dart';
import 'package:taskify/core/usecase/usecase.dart';
import 'package:taskify/features/tasks/domain/entities/task.dart';
import 'package:taskify/features/tasks/domain/repositories/task_repository.dart';

class GetAllTasks implements UseCase<List<Tasks>, NoParams> {
  final TaskRepository repository;

  GetAllTasks(this.repository);

  @override
  Either<Failure, List<Tasks>> call(NoParams params) {
    return repository.getAllTasks();
  }
}
