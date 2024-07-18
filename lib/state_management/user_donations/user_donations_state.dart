import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_donation.dart';
import 'package:crowdfunding_flutter/domain/model/tax_receipt/tax_receipt.dart';
import 'package:equatable/equatable.dart';

final class UserDonationsState extends Equatable {
  final ApiResult<List<CampaignDonation>> userDonationsResult;
  final ApiResult<TaxReceipt> taxReceiptResult;

  const UserDonationsState({
    required this.userDonationsResult,
    required this.taxReceiptResult,
  });

  const UserDonationsState.initial()
      : this(userDonationsResult: const ApiResultInitial(),
            taxReceiptResult: const ApiResultInitial(),);

  UserDonationsState copyWith({
    ApiResult<List<CampaignDonation>>? userDonationsResult,
    ApiResult<TaxReceipt>? taxReceiptResult,
  }) {
    return UserDonationsState(
      userDonationsResult: userDonationsResult ?? this.userDonationsResult,
      taxReceiptResult: taxReceiptResult ?? this.taxReceiptResult,
    );
  }

  @override
  List<Object> get props => [userDonationsResult, taxReceiptResult,];
}
