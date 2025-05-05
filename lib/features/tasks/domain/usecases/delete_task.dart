import 'package:fpdart/fpdart.dart';
import 'package:taskify/core/error/failures.dart';
import 'package:taskify/core/usecase/usecase.dart';
import 'package:taskify/features/tasks/domain/repositories/task_repository.dart';

class DeleteTask implements UseCase<void, DeleteParams> {
  final TaskRepository repository;

  DeleteTask(this.repository);

  @override
  Either<Failure, void> call(DeleteParams params) {
    return repository.deleteTask(params.id);
  }
}

class DeleteParams {
  final String id;

  DeleteParams(this.id);
}
