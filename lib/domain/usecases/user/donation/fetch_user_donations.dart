import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_donation.dart';
import 'package:crowdfunding_flutter/domain/repository/user/user_repository.dart';
import 'package:fpdart/fpdart.dart';

class FetchUserDonations implements UseCase<List<CampaignDonation>, NoPayload> {
  final UserRepository userRepository;

  FetchUserDonations({required this.userRepository});

  @override
  Future<Either<Failure, List<CampaignDonation>>> call(
      NoPayload payload) async {
    return await userRepository.getUserDonations();
  }
}
