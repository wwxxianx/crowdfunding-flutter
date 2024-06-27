import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/payload/scam_report/create_scam_report_payload.dart';
import 'package:crowdfunding_flutter/data/network/retrofit_api.dart';
import 'package:crowdfunding_flutter/domain/model/scam_report/scam_report.dart';
import 'package:crowdfunding_flutter/domain/repository/scam_report/scam_report_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/src/either.dart';

class ScamReportRepositoryImpl implements ScamReportRepository {
  final RestClient api;

  const ScamReportRepositoryImpl({required this.api});

  @override
  Future<Either<Failure, ScamReport>> createScamReport(
      CreateScamReportPayload payload) async {
    try {
      final res = await api.createScamReport(
        evidenceImageFiles: payload.evidenceImageFiles,
        documentFiles: payload.documentFiles,
        campaignId: payload.campaignId,
        description: payload.description,
      );
      return right(res);
    } on Exception catch (e) {
      if (e is DioException) {
        final errorMessage = ErrorHandler.dioException(error: e).errorMessage;
        return left(Failure(errorMessage));
      }
      return left(Failure(ErrorHandler.otherException().errorMessage));
    }
  }
}
