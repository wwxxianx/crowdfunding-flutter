import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/domain/model/collaboration/collaboration.dart';
import 'package:crowdfunding_flutter/domain/repository/collaboration/collaboration_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchCampaignCollaboration implements UseCase<Collaboration?, String> {
  final CollaborationRepository collaborationRepository;

  const FetchCampaignCollaboration({required this.collaborationRepository});

  @override
  Future<Either<Failure, Collaboration?>> call(String payload) async {
    return await collaborationRepository.getCollaboration(campaignId: payload);
  }
}
