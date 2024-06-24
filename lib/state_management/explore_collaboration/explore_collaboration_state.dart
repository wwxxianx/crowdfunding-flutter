import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/collaboration/collaboration.dart';
import 'package:equatable/equatable.dart';

final class ExploreCollaborationState extends Equatable {
  final ApiResult<List<Collaboration>> collaborationsResult;
  final ApiResult<Collaboration> takeCollaborationResult;

  const ExploreCollaborationState._({
    this.collaborationsResult = const ApiResultInitial(),
    this.takeCollaborationResult = const ApiResultInitial(),
  });

  const ExploreCollaborationState.initial() : this._();

  ExploreCollaborationState copyWith({
    ApiResult<List<Collaboration>>? collaborationsResult,
    ApiResult<Collaboration>? takeCollaborationResult,
  }) {
    return ExploreCollaborationState._(
      collaborationsResult: collaborationsResult ?? this.collaborationsResult,
      takeCollaborationResult:
          takeCollaborationResult ?? this.takeCollaborationResult,
    );
  }

  @override
  List<Object?> get props => [
        collaborationsResult,
        takeCollaborationResult,
      ];
}
