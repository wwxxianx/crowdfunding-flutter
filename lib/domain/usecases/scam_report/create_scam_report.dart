import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/data/network/payload/scam_report/create_scam_report_payload.dart';
import 'package:crowdfunding_flutter/domain/model/scam_report/scam_report.dart';
import 'package:crowdfunding_flutter/domain/repository/scam_report/scam_report_repository.dart';
import 'package:fpdart/src/either.dart';

class CreateScamReport implements UseCase<ScamReport, CreateScamReportPayload> {
  final ScamReportRepository scamReportRepository;

  const CreateScamReport({required this.scamReportRepository});

  @override
  Future<Either<Failure, ScamReport>> call(
      CreateScamReportPayload payload) async {
    return await scamReportRepository.createScamReport(payload);
  }
}
