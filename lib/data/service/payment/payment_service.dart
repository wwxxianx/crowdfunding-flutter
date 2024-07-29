import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/payload/stripe/update_connect_account_payload.dart';
import 'package:crowdfunding_flutter/data/network/response/payment/connect_account_response.dart';
import 'package:crowdfunding_flutter/data/network/retrofit_api.dart';
import 'package:crowdfunding_flutter/data/service/payment/campaign_donation/create_campaign_donation_payment_intent_payload.dart';
import 'package:crowdfunding_flutter/data/service/payment/gift_card/create_gift_card_payment_intent_payload.dart';
import 'package:crowdfunding_flutter/data/service/payment/payment_intent_response.dart';
import 'package:crowdfunding_flutter/domain/model/stripe/stripe_account.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';

class PaymentService {
  final logger = Logger();
  final RestClient api;

  PaymentService({required this.api});

  Future<Either<Failure, ConnectAccountResponse>> getUpdateConnectAccountLink(
      {required UpdateConnectAccountPayload payload}) async {
    try {
      final res = await api.updateConnectAccount(payload);
      return right(res);
    } catch (e) {
      return left(Failure('Failed to get connected account link'));
    }
  }

  Future<Either<Failure, StripeAccount>> getConnectedAccount(
      {required String connectedAccountId}) async {
    try {
      final res =
          await api.getConnectedAccount(connectedAccountId: connectedAccountId);
      return right(res);
    } catch (e) {
      return left(Failure('Failed to get connected account details'));
    }
  }

  Future<Either<Failure, ConnectAccountResponse>> connectAccount() async {
    try {
      final res = await api.connectStripeAccount();
      return right(res);
    } catch (e) {
      return left(Failure('Failed to connect account'));
    }
  }

  Future<Either<Failure, ConnectAccountResponse>> connectOrganizationStripeAccount() async {
    try {
      final res = await api.connectOrganizationStripeAccount();
      return right(res);
    } on Exception catch (e) {
      if (e is DioException) {
        final errorMessage = ErrorHandler.dioException(error: e).errorMessage;
        return left(Failure(errorMessage));
      }
      return left(Failure(ErrorHandler.otherException().errorMessage));
    }
  }

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
      final PaymentIntentResponse paymentIntentRes = await api
          .createCampaignDonationPaymentIntent(createPaymentIntentPayload);
      // Set to campaign launcher's stripe account id to receive donation
      // Stripe.stripeAccountId = paymentIntentRes.stripeAccountId;
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
