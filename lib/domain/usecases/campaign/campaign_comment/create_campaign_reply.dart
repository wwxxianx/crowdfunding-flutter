import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/data/network/payload/campaign/create_campaign_reply_payload.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_comment.dart';
import 'package:crowdfunding_flutter/domain/repository/campaign/campaign_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:fpdart/src/either.dart';

class CreateCampaignReply implements UseCase<CampaignComment, CreateCampaignReplyPayload> {
  final CampaignRepository campaignRepository;

  CreateCampaignReply({required this.campaignRepository});

  @override
  Future<Either<Failure, CampaignComment>> call(CreateCampaignReplyPayload payload) async {
    return await campaignRepository.createCampaignReply(payload);
  }
}
