import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/data/network/payload/stripe/update_connect_account_payload.dart';
import 'package:crowdfunding_flutter/data/network/response/payment/connect_account_response.dart';
import 'package:crowdfunding_flutter/data/service/payment/payment_service.dart';
import 'package:fpdart/src/either.dart';

class UpdateConnectAccount
    implements UseCase<ConnectAccountResponse, UpdateConnectAccountPayload> {
  final PaymentService paymentService;
  const UpdateConnectAccount({required this.paymentService});

  @override
  Future<Either<Failure, ConnectAccountResponse>> call(
      UpdateConnectAccountPayload payload) async {
    return await paymentService.getUpdateConnectAccountLink(payload: payload);
  }
}
