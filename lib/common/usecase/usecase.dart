import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<SuccessType, Payload> {
  Future<Either<Failure, SuccessType>> call(Payload payload);
}

class NoPayload {}
