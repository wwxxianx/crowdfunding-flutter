import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/data/network/retrofit_api.dart';
import 'package:crowdfunding_flutter/data/service/payment/campaign_donation/create_campaign_donation_payment_intent_payload.dart';
import 'package:crowdfunding_flutter/data/service/payment/gift_card/create_gift_card_payment_intent_payload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';

class PaymentService {
  final logger = Logger();
  final RestClient api;

  PaymentService({required this.api});

  Future<Either<Failure, Unit>> testPayment() async {
    try {
      // 1. create payment intent on the server
      final paymentIntentRes = await api.testPayment();
      Stripe.stripeAccountId = "acct_1PMlpIIer2iU8p47";
      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Set to true for custom flow
          customFlow: false,
          // Main params
          merchantDisplayName: 'Flutter Stripe Store Demo',
          paymentIntentClientSecret: paymentIntentRes.clientSecret,
          // Customer keys
          customerEphemeralKeySecret: paymentIntentRes.ephemeralKey,
          customerId: paymentIntentRes.customer,
          style: ThemeMode.light,
          billingDetailsCollectionConfiguration:
              const BillingDetailsCollectionConfiguration(
            address: AddressCollectionMode.never,
          ),
        ),
      );
      return right(unit);
    } catch (e) {
      logger.w("Error: $e");
      return left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, Unit>> initCampaignDonationPaymentSheet(
    CreateCampaignDonationPaymentIntentPayload createPaymentIntentPayload,
  ) async {
    try {
      // 1. create payment intent on the server
      final paymentIntentRes = await api
          .createCampaignDonationPaymentIntent(createPaymentIntentPayload);

      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Set to true for custom flow
          customFlow: false,
          // Main params
          merchantDisplayName: 'Flutter Stripe Store Demo',
          paymentIntentClientSecret: paymentIntentRes.clientSecret,
          // Customer keys
          customerEphemeralKeySecret: paymentIntentRes.ephemeralKey,
          customerId: paymentIntentRes.customer,
          style: ThemeMode.light,
          billingDetailsCollectionConfiguration:
              const BillingDetailsCollectionConfiguration(
            address: AddressCollectionMode.never,
          ),
        ),
      );
      return right(unit);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, Unit>> initGiftCardPaymentSheet(
    CreateGiftCardPaymentIntentPayload createPaymentIntentPayload,
  ) async {
    try {
      // 1. create payment intent on the server
      final paymentIntentRes =
          await api.createGiftCardPaymentIntent(createPaymentIntentPayload);

      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Set to true for custom flow
          customFlow: false,
          // Main params
          merchantDisplayName: 'Flutter Stripe Store Demo',
          paymentIntentClientSecret: paymentIntentRes.clientSecret,
          // Customer keys
          customerEphemeralKeySecret: paymentIntentRes.ephemeralKey,
          customerId: paymentIntentRes.customer,
          style: ThemeMode.light,
          billingDetailsCollectionConfiguration:
              const BillingDetailsCollectionConfiguration(
            address: AddressCollectionMode.never,
          ),
        ),
      );
      return right(unit);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, Unit>> presentPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
    return right(unit);
    // try {
    //   await Stripe.instance.presentPaymentSheet();
    //   return right(unit);
    // } catch (e) {
    //   logger.w("Error: $e");
    //   return left(Failure("Failed to pay..."));
    // }
  }
}
