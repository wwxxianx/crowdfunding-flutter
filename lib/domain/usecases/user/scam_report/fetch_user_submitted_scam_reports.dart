import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/domain/model/scam_report/scam_report.dart';
import 'package:crowdfunding_flutter/domain/repository/user/user_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchUserSubmittedScamReports
    implements UseCase<List<ScamReport>, NoPayload> {
  final UserRepository userRepository;

  FetchUserSubmittedScamReports({required this.userRepository});

  @override
  Future<Either<Failure, List<ScamReport>>> call(NoPayload payload) async {
    return await userRepository.getUserSubmittedScamReports();
  }
}
