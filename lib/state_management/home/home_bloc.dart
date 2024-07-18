import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/payload/organization/get_organizations_payload.dart';
import 'package:crowdfunding_flutter/data/service/payment/payment_service.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/enum/campaign_enum.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/fetch_campaigns.dart';
import 'package:crowdfunding_flutter/domain/usecases/organization/fetch_organizations.dart';
import 'package:crowdfunding_flutter/state_management/home/home_event.dart';
import 'package:crowdfunding_flutter/state_management/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FetchCampaigns _fetchCampaign;
  final PaymentService _paymentService;
  final FetchOrganizations _fetchOrganizations;

  HomeBloc({
    required FetchCampaigns fetchCampaign,
    required PaymentService paymentService,
    required FetchOrganizations fetchOrganizations,
  })  : _fetchCampaign = fetchCampaign,
        _paymentService = paymentService,
        _fetchOrganizations = fetchOrganizations,
        super(const HomeState.initial()) {
    on<HomeEvent>(_onEvent);
  }

  Future<void> _onEvent(
    HomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    return switch (event) {
      final OnInitData e => _onInitData(e, emit),
      final OnFetchRecommendedCampaigns e =>
        _onFetchRecommendedCampaigns(e, emit),
      final TestPayment e => testPayment(e, emit),
      final OnFetchOrganizations e => _onFetchOrganizations(e, emit),
      final OnFetchSuccessfulCampaigns e =>
        _onFetchSuccessfulCampaigns(e, emit),
    };
  }

  Future<void> _onFetchOrganizations(
    OnFetchOrganizations event,
    Emitter<HomeState> emit,
  ) async {
    final res = await _fetchOrganizations(GetOrganizationsPayload());
    res.fold(
      (failure) => emit(state.copyWith(
          organizationsResult: ApiResultFailure(failure.errorMessage))),
      (organizations) {
        emit(state.copyWith(
            organizationsResult: ApiResultSuccess(organizations)));
      },
    );
  }

  Future<void> _onFetchSuccessfulCampaigns(
    OnFetchSuccessfulCampaigns event,
    Emitter<HomeState> emit,
  ) async {
    final res =
        await _fetchCampaign(const FetchCampaignsPayload(isCompleted: true));
    res.fold(
      (failure) => emit(state.copyWith(
          completedCampaignsResult: ApiResultFailure(failure.errorMessage))),
      (campaigns) {
        emit(state.copyWith(
            completedCampaignsResult: ApiResultSuccess(campaigns)));
      },
    );
  }

  Future<void> _onInitData(
    OnInitData event,
    Emitter<HomeState> emit,
  ) async {
    final recommendedCampaignsResult = state.recommendedCampaignsResult;
    final organizationsResult = state.organizationsResult;
    if (recommendedCampaignsResult is! ApiResultSuccess<List<Campaign>>) {
      await _onFetchRecommendedCampaigns(OnFetchRecommendedCampaigns(), emit);
    }
    if (organizationsResult is! ApiResultSuccess<List<Organization>>) {
      await _onFetchOrganizations(OnFetchOrganizations(), emit);
    }
    if (state.completedCampaignsResult is! ApiResultSuccess<List<Campaign>>) {
      await _onFetchSuccessfulCampaigns(OnFetchSuccessfulCampaigns(), emit);
    }
  }

  Future<void> testPayment(
    TestPayment event,
    Emitter emit,
  ) async {
    final paymentIntentRes = await _paymentService.testPayment();
    paymentIntentRes.fold(
      (failure) {},
      (unit) async {
        final paymentRes = await _paymentService.presentPaymentSheet();
        paymentRes.fold(
          (l) {
            if (emit.isDone) return;
          },
          (r) {
            // if (emit.isDone) return;
            // emit(state.copyWith(isCreatingDonation: false));
          },
        );
      },
    );
  }

  Future<void> _onFetchRecommendedCampaigns(
    OnFetchRecommendedCampaigns event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(recommendedCampaignsResult: const ApiResultLoading()));
    const payload = FetchCampaignsPayload(
      userId: null,
      isPublished: true,
      identificationStatus: IdentificationStatusEnum.VERIFIED,
    );
    final res = await _fetchCampaign.call(payload);
    res.fold(
      (l) => emit(state.copyWith(
          recommendedCampaignsResult: ApiResultFailure(l.errorMessage))),
      (r) =>
          emit(state.copyWith(recommendedCampaignsResult: ApiResultSuccess(r))),
    );
  }
}
