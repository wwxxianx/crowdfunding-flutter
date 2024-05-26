import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_update.dart';
import 'package:equatable/equatable.dart';

final class CreateCampaignUpdateState extends Equatable {
  final String? titleError;
  final String? descriptionError;
  final ApiResult<CampaignUpdate> createUpdateResult;

  const CreateCampaignUpdateState._({
    this.descriptionError,
    this.titleError,
    this.createUpdateResult = const ApiResultInitial(),
  });

  const CreateCampaignUpdateState.initial() : this._();

  CreateCampaignUpdateState copyWith({
    String? titleError,
    String? descriptionError,
    ApiResult<CampaignUpdate>? createUpdateResult,
  }) {
    return CreateCampaignUpdateState._(
      titleError: titleError ?? this.titleError,
      descriptionError: descriptionError ?? this.descriptionError,
      createUpdateResult: createUpdateResult ?? this.createUpdateResult,
    );
  }

  @override
  List<Object?> get props => [titleError, descriptionError, createUpdateResult];
}
