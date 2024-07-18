import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/data/network/payload/user/tax_receipt/get_tax_receipt_payload.dart';
import 'package:crowdfunding_flutter/domain/model/tax_receipt/tax_receipt.dart';
import 'package:crowdfunding_flutter/domain/repository/user/user_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchTaxReceipt implements UseCase<TaxReceipt, GetTaxReceiptPayload> {
  final UserRepository userRepository;

  FetchTaxReceipt({required this.userRepository});

  @override
  Future<Either<Failure, TaxReceipt>> call(GetTaxReceiptPayload payload) async {
    return await userRepository.getUserTaxReceipt(payload);
  }
}
