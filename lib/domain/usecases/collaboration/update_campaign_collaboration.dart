import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/data/network/payload/collaboration/update_collaboration_payload.dart';
import 'package:crowdfunding_flutter/domain/model/collaboration/collaboration.dart';
import 'package:crowdfunding_flutter/domain/repository/collaboration/collaboration_repository.dart';
import 'package:fpdart/src/either.dart';

class UpdateCampaignCollaboration
    implements UseCase<Collaboration, UpdateCollaborationPayload> {
  final CollaborationRepository collaborationRepository;

  const UpdateCampaignCollaboration({required this.collaborationRepository});

  @override
  Future<Either<Failure, Collaboration>> call(
      UpdateCollaborationPayload payload) async {
    return await collaborationRepository.updateCollaboration(payload: payload);
  }
}
