import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/data/network/payload/collaboration/create_collaboration_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/collaboration/update_collaboration_payload.dart';
import 'package:crowdfunding_flutter/domain/model/collaboration/collaboration.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CollaborationRepository {
  Future<Either<Failure, List<Collaboration>>> getCollaborations();
  Future<Either<Failure, List<Collaboration>>> getPendingCollaborations();
  Future<Either<Failure, Collaboration?>> getCollaboration(
      {required String campaignId});
  Future<Either<Failure, Collaboration>> createCollaboration(
      CreateCollaborationPayload payload);

  Future<Either<Failure, Collaboration>> updateCollaboration({
    required UpdateCollaborationPayload payload,
  });
}