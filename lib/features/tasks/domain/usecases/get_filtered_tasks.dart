import 'package:fpdart/fpdart.dart';
import 'package:taskify/core/error/failures.dart';
import 'package:taskify/core/usecase/usecase.dart';
import 'package:taskify/features/tasks/domain/entities/task.dart';
import 'package:taskify/features/tasks/domain/repositories/task_repository.dart';

class GetFilteredTasks implements UseCase<List<Tasks>, FilterParams> {
  final TaskRepository repository;

  GetFilteredTasks(this.repository);

  @override
  Either<Failure, List<Tasks>> call(FilterParams params) {
    return repository.getFilteredTasks(params.status);
  }
}

class FilterParams {
  final String status;

  FilterParams(this.status);
}
