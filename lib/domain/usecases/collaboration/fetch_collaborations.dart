import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/data/network/payload/collaboration/fetch_collaboration_filter.dart';
import 'package:crowdfunding_flutter/domain/model/collaboration/collaboration.dart';
import 'package:crowdfunding_flutter/domain/repository/collaboration/collaboration_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchCollaborations
    implements UseCase<List<Collaboration>, FetchCollaborationFilter> {
  final CollaborationRepository collaborationRepository;

  const FetchCollaborations({required this.collaborationRepository});

  @override
  Future<Either<Failure, List<Collaboration>>> call(
      FetchCollaborationFilter payload) async {
    return await collaborationRepository.getCollaborations(payload);
  }
}
