import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/data/network/payload/collaboration/create_collaboration_payload.dart';
import 'package:crowdfunding_flutter/domain/model/collaboration/collaboration.dart';
import 'package:crowdfunding_flutter/domain/repository/collaboration/collaboration_repository.dart';
import 'package:fpdart/src/either.dart';

class CreateCampaignCollaboration
    implements UseCase<Collaboration, CreateCollaborationPayload> {
  final CollaborationRepository collaborationRepository;

  const CreateCampaignCollaboration({required this.collaborationRepository});

  @override
  Future<Either<Failure, Collaboration>> call(
      CreateCollaborationPayload payload) async {
    return await collaborationRepository.createCollaboration(payload);
  }
}
