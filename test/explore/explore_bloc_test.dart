import 'package:bloc_test/bloc_test.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_category.dart';
import 'package:crowdfunding_flutter/domain/model/state/state_region.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/fetch_campaigns.dart';
import 'package:crowdfunding_flutter/state_management/explore/explore_campaigns_bloc.dart';
import 'package:crowdfunding_flutter/state_management/explore/explore_campaigns_event.dart';
import 'package:crowdfunding_flutter/state_management/explore/explore_campaigns_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockFetchCampaignsUseCase extends Mock implements FetchCampaigns {}

void main() {
  group('ExploreCampaignsBloc', () {
    late List<Campaign> mockData;
    late FetchCampaigns fetchCampaigns;
    late ExploreCampaignsBloc exploreCampaignsBloc;

    setUp(() {
      mockData = Campaign.samples;
      fetchCampaigns = MockFetchCampaignsUseCase();
      exploreCampaignsBloc =
          ExploreCampaignsBloc(fetchCampaigns: fetchCampaigns);
      registerFallbackValue(const FetchCampaignsPayload(
        categoryIds: [],
        identificationStatus: null,
        isCompleted: true,
        isPublished: true,
        searchQuery: null,
        stateIds: [],
        userId: null,
      ));
    });

    test('initial state is correct', () {
      expect(exploreCampaignsBloc.state, const ExploreCampaignsState.initial());
    });

    group('Filter campaigns', () {
      // Mock data
      final mockCategoryIds = CampaignCategory.samples.first.id;
      final mockStateIds = StateAndRegion.samples.first.id;
      blocTest(
        "appends new category id if it's not selected yet",
        build: () => exploreCampaignsBloc,
        act: (bloc) =>
            bloc.add(const OnSelectCampaignCategory(categoryId: '1')),
        expect: () => [
          const ExploreCampaignsState(
              campaignsResult: ApiResultInitial(), selectedCategoryIds: ['1']),
        ],
      );

      blocTest(
        "removes category id if it's already selected",
        build: () => exploreCampaignsBloc,
        seed: () => const ExploreCampaignsState(
            campaignsResult: ApiResultInitial(),
            selectedCategoryIds: ['1', '2']),
        act: (bloc) =>
            bloc.add(const OnSelectCampaignCategory(categoryId: '2')),
        expect: () => [
          const ExploreCampaignsState(
              campaignsResult: ApiResultInitial(), selectedCategoryIds: ['1'])
        ],
      );

      blocTest(
        "appends new state id if it's not selected yet",
        build: () => exploreCampaignsBloc,
        act: (bloc) => bloc.add(const OnSelectStateAndRegion(stateId: '1')),
        expect: () => [
          const ExploreCampaignsState(
              campaignsResult: ApiResultInitial(), selectedStateIds: ['1'])
        ],
      );

      blocTest(
        "removes state id if it's already selected",
        build: () => exploreCampaignsBloc,
        seed: () => const ExploreCampaignsState(
            campaignsResult: ApiResultInitial(), selectedStateIds: ['1', '2']),
        act: (bloc) => bloc.add(const OnSelectStateAndRegion(stateId: '2')),
        expect: () => [
          const ExploreCampaignsState(
              campaignsResult: ApiResultInitial(), selectedStateIds: ['1'])
        ],
      );

      blocTest(
        "emits entered searchQuery",
        build: () => exploreCampaignsBloc,
        act: (bloc) =>
            bloc.add(const OnSearchQueryChanged(searchQuery: 'searchQuery')),
        expect: () => [
          const ExploreCampaignsState(
              campaignsResult: const ApiResultInitial(),
              searchQuery: 'searchQuery'),
        ],
      );

      blocTest<ExploreCampaignsBloc, ExploreCampaignsState>(
        'emits new campaigns based on category filters',
        build: () => exploreCampaignsBloc,
        seed: () => ExploreCampaignsState(
            campaignsResult: const ApiResultInitial(),
            selectedCategoryIds: [mockCategoryIds]),
        act: (bloc) {
          when(() => fetchCampaigns.call(any())).thenAnswer((invocation) async {
            final expectedData = mockData
                .filter((campaign) =>
                    campaign.campaignCategory.id == mockCategoryIds)
                .toList();
            return right(expectedData);
          });
          return bloc.add(OnFetchCampaigns());
        },
        expect: () {
          final expectedData = mockData
              .filter(
                  (campaign) => campaign.campaignCategory.id == mockCategoryIds)
              .toList();
          return [
            ExploreCampaignsState(
                campaignsResult: const ApiResultLoading<List<Campaign>>(),
                selectedCategoryIds: [mockCategoryIds]),
            ExploreCampaignsState(
                campaignsResult: ApiResultSuccess<List<Campaign>>(expectedData),
                selectedCategoryIds: [mockCategoryIds]),
          ];
        },
      );

      blocTest<ExploreCampaignsBloc, ExploreCampaignsState>(
        'emits new campaigns based on state filters',
        build: () => exploreCampaignsBloc,
        seed: () => ExploreCampaignsState(
            campaignsResult: const ApiResultInitial(),
            selectedStateIds: [mockStateIds]),
        act: (bloc) {
          when(() => fetchCampaigns.call(any())).thenAnswer((invocation) async {
            final expectedData = mockData
                .filter(
                    (campaign) => campaign.stateAndRegion.id == mockStateIds)
                .toList();
            return right(expectedData);
          });
          return bloc.add(OnFetchCampaigns());
        },
        expect: () {
          final expectedData = mockData
              .filter((campaign) => campaign.stateAndRegion.id == mockStateIds)
              .toList();
          return [
            ExploreCampaignsState(
                campaignsResult: const ApiResultLoading<List<Campaign>>(),
                selectedStateIds: [mockStateIds]),
            ExploreCampaignsState(
                campaignsResult: ApiResultSuccess<List<Campaign>>(expectedData),
                selectedStateIds: [mockStateIds]),
          ];
        },
      );
    });
  });
}
