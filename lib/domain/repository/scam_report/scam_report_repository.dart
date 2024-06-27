import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/data/network/payload/scam_report/create_scam_report_payload.dart';
import 'package:crowdfunding_flutter/domain/model/scam_report/scam_report.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ScamReportRepository {
  Future<Either<Failure, ScamReport>> createScamReport(
      CreateScamReportPayload payload);
}
