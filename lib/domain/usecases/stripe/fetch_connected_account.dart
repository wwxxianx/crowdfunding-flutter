import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/data/service/payment/payment_service.dart';
import 'package:crowdfunding_flutter/domain/model/stripe/stripe_account.dart';
import 'package:fpdart/src/either.dart';

class FetchConnectedAccount implements UseCase<StripeAccount, String> {
  final PaymentService paymentService;

  const FetchConnectedAccount({required this.paymentService});

  @override
  Future<Either<Failure, StripeAccount>> call(String payload) async {
    return await paymentService.getConnectedAccount(
        connectedAccountId: payload);
  }
}
