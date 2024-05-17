import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/domain/model/state/state_region.dart';
import 'package:fpdart/fpdart.dart';

abstract class ConstantRepository {
  Future<Either<Failure, List<StateAndRegion>>> getStateAndRegions();
}
