import 'package:crowdfunding_flutter/data/service/payment/create_payment_intent_payload.dart';
import 'package:crowdfunding_flutter/data/service/payment/payment_service.dart';
import 'package:crowdfunding_flutter/state_management/donate/donate_event.dart';
import 'package:crowdfunding_flutter/state_management/donate/donate_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonateBloc extends Bloc<DonateEvent, DonateState> {
  final PaymentService _paymentService;

  DonateBloc({
    required PaymentService paymentService,
  })  : _paymentService = paymentService,
        super(const DonateState.initial()) {
    on<DonateEvent>(_onEvent);
  }

  Future<void> _onEvent(
    DonateEvent event,
    Emitter<DonateState> emit,
  ) {
    return switch (event) {
      final OnCreateDonation e => _onCreateDonation(e, emit),
    };
  }

  Future<void> _onCreateDonation(
    OnCreateDonation event,
    Emitter<DonateState> emit,
  ) async {
    emit(state.copyWith(isCreatingDonation: true));
    final payload = CreatePaymentIntentPayload(
      amount: event.amount,
      campaignId: event.campaignId,
      isAnonymous: event.isAnonymous,
    );
    final res = await _paymentService.initPaymentSheet(event.context, payload);
    res.fold(
      (l) => null,
      (r) async {
        await _paymentService.presentPaymentSheet().whenComplete(
            () => emit(state.copyWith(isCreatingDonation: false)));
      },
    );
  }
}
