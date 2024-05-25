import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/data/network/retrofit_api.dart';
import 'package:crowdfunding_flutter/data/service/payment/create_payment_intent_payload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fpdart/fpdart.dart';

class PaymentService {
  final RestClient api;

  PaymentService({required this.api});

  Future<Either<Failure, Unit>> initPaymentSheet(
    BuildContext context,
    CreatePaymentIntentPayload createPaymentIntentPayload,
  ) async {
    try {
      // 1. create payment intent on the server
      final paymentIntentRes =
          await api.createPaymentIntent(createPaymentIntentPayload);

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
          // Extra options
          // applePay: const PaymentSheetApplePay(
          //   merchantCountryCode: 'US',
          // ),
          // googlePay: const PaymentSheetGooglePay(
          //   merchantCountryCode: 'US',
          //   testEnv: true,
          // ),
          style: ThemeMode.light,
        ),
      );
      return right(unit);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      return left(Failure(e.toString()));
    }
  }

  Future<void> presentPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }
}
