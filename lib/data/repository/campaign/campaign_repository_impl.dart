import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/retrofit_api.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/repository/campaign/campaign_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/src/either.dart';

class CampaignRepositoryImpl implements CampaignRepository {
  final RestClient api;

  CampaignRepositoryImpl({required this.api});

  @override
  Future<Either<Failure, List<Campaign>>> getCampaigns() async {
    try {
      final campaignsRes = await api.getCampaigns();
      return right(campaignsRes);
    } catch (e) {
      if (e is DioException) {
        final errorMessage = ErrorHandler.dioException(error: e).errorMessage;
        return left(Failure(errorMessage));
      }
      return left(Failure(ErrorHandler.otherException().errorMessage));
    }
  }
}
