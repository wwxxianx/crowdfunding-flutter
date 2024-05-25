import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:equatable/equatable.dart';

final class MyCampaignState extends Equatable {
  final ApiResult<List<Campaign>> myCampaignsResult;

  const MyCampaignState._({
    required this.myCampaignsResult,
  });

  const MyCampaignState.initial()
      : this._(myCampaignsResult: const ApiResultInitial());
  const MyCampaignState.fetchMyCampaignsInProgress()
      : this._(myCampaignsResult: const ApiResultLoading());
  MyCampaignState.fetchMyCampaignsSuccess({required List<Campaign> data})
      : this._(myCampaignsResult: ApiResultSuccess(data));
  MyCampaignState.fetchMyCampaignFailure(String? errorMessage)
      : this._(myCampaignsResult: ApiResultFailure(errorMessage));

  @override
  List<Object?> get props => [myCampaignsResult];
}
