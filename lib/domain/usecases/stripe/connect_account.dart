import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/data/network/response/payment/connect_account_response.dart';
import 'package:crowdfunding_flutter/data/service/payment/payment_service.dart';
import 'package:fpdart/src/either.dart';

class ConnectAccount implements UseCase<ConnectAccountResponse, NoPayload> {
  final PaymentService paymentService;

  const ConnectAccount({required this.paymentService});

  @override
  Future<Either<Failure, ConnectAccountResponse>> call(
      NoPayload payload) async {
    return await paymentService.connectAccount();
  }
}
