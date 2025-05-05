import 'package:fpdart/fpdart.dart';
import 'package:taskify/core/error/failures.dart';

abstract interface class UseCase<SuccessType, Params> {
  Either<Failure, SuccessType> call(Params params);
}

class NoParams {}
