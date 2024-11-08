import 'package:crowdfunding_flutter/data/network/payload/donation/create_campaign_donation_payload.dart';
import 'package:crowdfunding_flutter/data/service/payment/campaign_donation/create_campaign_donation_payment_intent_payload.dart';
import 'package:crowdfunding_flutter/data/service/payment/payment_service.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/donation/create_giftcard_donation.dart';
import 'package:crowdfunding_flutter/state_management/donate/donate_event.dart';
import 'package:crowdfunding_flutter/state_management/donate/donate_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class DonateBloc extends Bloc<DonateEvent, DonateState> {
  final PaymentService _paymentService;
  final CreateGiftCardDonation _createGiftCardDonation;

  DonateBloc({
    required PaymentService paymentService,
    required CreateGiftCardDonation createGiftCardDonation,
  })  : _paymentService = paymentService,
        _createGiftCardDonation = createGiftCardDonation,
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
    if (event.giftCardId != null) {
      // Donate using gift
      final createGiftCardDonationPayload = CreateGiftCardDonationPayload(
        campaignId: event.campaignId,
        isAnonymous: event.isAnonymous,
        giftCardId: event.giftCardId!,
      );
      final res =
          await _createGiftCardDonation.call(createGiftCardDonationPayload);
      res.fold(
        (failure) {
          // TODO: Handle error
          emit(state.copyWith(
              isCreatingDonation: false,
              createDonationError: failure.errorMessage));
        },
        (res) {
          if (!res.result) {
            // TODO: Handle error
            emit(
              state.copyWith(
                  isCreatingDonation: false,
                  createDonationError:
                      'Failed to donate, please try again later.'),
            );
            return;
          }
          emit(state.copyWith(isCreatingDonation: false));
          event.onSuccess();
        },
      );
      return;
    }
    final payload = CreateCampaignDonationPaymentIntentPayload(
      amount: event.amount,
      campaignId: event.campaignId,
      isAnonymous: event.isAnonymous,
      giftCardId: event.giftCardId,
    );
    final paymentIntentRes =
        await _paymentService.initCampaignDonationPaymentSheet(payload);
    paymentIntentRes.fold(
      (failure) {
        emit(state.copyWith(
              isCreatingDonation: false,
              createDonationError: failure.errorMessage));
      },
      (unit) async {
        final paymentRes = await _paymentService.presentPaymentSheet();
        paymentRes.fold(
          (l) {
            if (emit.isDone) return;
            emit(state.copyWith(isCreatingDonation: false));
          },
          (r) {
            if (emit.isDone) return;
            emit(state.copyWith(isCreatingDonation: false));
          },
        );
        event.onSuccess();
      },
    );
    Stripe.stripeAccountId = null;
    // final paymentIntentRes = await _paymentService.testPayment();
    // paymentIntentRes.fold(
    //   (failure) {},
    //   (unit) async {
    //     final paymentRes = await _paymentService.presentPaymentSheet();
    //     paymentRes.fold(
    //       (l) {
    //         print("Failed");
    //         if (emit.isDone) return;
    //       },
    //       (r) {
    //         print("Done!!");
    //         // if (emit.isDone) return;
    //         // emit(state.copyWith(isCreatingDonation: false));
    //       },
    //     );
    //   },
    // );
  }
}
