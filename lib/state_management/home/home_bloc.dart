import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/service/payment/payment_service.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/fetch_campaigns.dart';
import 'package:crowdfunding_flutter/state_management/home/home_event.dart';
import 'package:crowdfunding_flutter/state_management/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FetchCampaigns _fetchCampaign;
  final PaymentService _paymentService;
  HomeBloc({
    required FetchCampaigns fetchCampaign,
    required PaymentService paymentService,
  })  : _fetchCampaign = fetchCampaign,
        _paymentService = paymentService,
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
    };
  }

  Future<void> _onInitData(
    OnInitData event,
    Emitter<HomeState> emit,
  ) async {
    final recommendedCampaignsResult = state.recommendedCampaignsResult;
    if (recommendedCampaignsResult is! ApiResultSuccess<List<Campaign>>) {
      await _onFetchRecommendedCampaigns(OnFetchRecommendedCampaigns(), emit);
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
    final res =
        await _fetchCampaign.call(const FetchCampaignsPayload(userId: null));
    res.fold(
      (l) => emit(state.copyWith(
          recommendedCampaignsResult: ApiResultFailure(l.errorMessage))),
      (r) =>
          emit(state.copyWith(recommendedCampaignsResult: ApiResultSuccess(r))),
    );
  }
}
