import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/domain/model/state/state_region.dart';
import 'package:crowdfunding_flutter/domain/repository/constant_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchStateAndRegions implements UseCase<List<StateAndRegion>, NoPayload> {
  final ConstantRepository constantRepository;

  const FetchStateAndRegions({required this.constantRepository});

  @override
  Future<Either<Failure, List<StateAndRegion>>> call(NoPayload payload) async {
    return await constantRepository.getStateAndRegions();
  }
}
