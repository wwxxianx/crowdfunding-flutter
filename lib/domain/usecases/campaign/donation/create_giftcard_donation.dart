import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/data/network/payload/donation/create_campaign_donation_payload.dart';
import 'package:crowdfunding_flutter/data/network/response/donation/giftcard_donation_response.dart';
import 'package:crowdfunding_flutter/domain/repository/campaign/campaign_repository.dart';
import 'package:fpdart/src/either.dart';

class CreateGiftCardDonation
    implements
        UseCase<GiftCardDonationResponse, CreateGiftCardDonationPayload> {
  final CampaignRepository campaignRepository;

  const CreateGiftCardDonation({required this.campaignRepository});

  @override
  Future<Either<Failure, GiftCardDonationResponse>> call(
      CreateGiftCardDonationPayload payload) async {
    return await campaignRepository.createGiftCardDonation(payload);
  }
}
