import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/domain/model/collaboration/collaboration.dart';
import 'package:crowdfunding_flutter/domain/repository/collaboration/collaboration_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchPendingCollaborations
    implements UseCase<List<Collaboration>, NoPayload> {
  final CollaborationRepository collaborationRepository;

  const FetchPendingCollaborations({required this.collaborationRepository});

  @override
  Future<Either<Failure, List<Collaboration>>> call(NoPayload payload) async {
    return await collaborationRepository.getPendingCollaborations();
  }
}
