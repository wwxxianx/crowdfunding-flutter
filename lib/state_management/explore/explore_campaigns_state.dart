import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:equatable/equatable.dart';

final class ExploreCampaignsState extends Equatable {
  final bool isGridView;
  final ApiResult<List<Campaign>> campaignsResult;
  final List<String> selectedStateIds;
  final List<String> selectedCategoryIds;
  final String? searchQuery;

  const ExploreCampaignsState({
    this.isGridView = false,
    required this.campaignsResult,
    this.selectedStateIds = const [],
    this.selectedCategoryIds = const [],
    this.searchQuery,
  });

  const ExploreCampaignsState.initial()
      : this(
          campaignsResult: const ApiResultInitial(),
        );

  ExploreCampaignsState copyWith({
    bool? isGridView,
    ApiResult<List<Campaign>>? campaignsResult,
    List<String>? selectedStateIds,
    List<String>? selectedCategoryIds,
    String? searchQuery,
  }) {
    return ExploreCampaignsState(
      isGridView: isGridView ?? this.isGridView,
      campaignsResult: campaignsResult ?? this.campaignsResult,
      selectedStateIds: selectedStateIds ?? this.selectedStateIds,
      selectedCategoryIds: selectedCategoryIds ?? this.selectedCategoryIds,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
        isGridView,
        campaignsResult,
        selectedStateIds,
        selectedCategoryIds,
        searchQuery,
      ];
}
