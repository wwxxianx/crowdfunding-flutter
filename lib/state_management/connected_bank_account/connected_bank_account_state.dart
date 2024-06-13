import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/response/payment/connect_account_response.dart';
import 'package:crowdfunding_flutter/domain/model/stripe/stripe_account.dart';
import 'package:equatable/equatable.dart';

final class ConnectedAccountState extends Equatable {
  final ApiResult<StripeAccount> stripeAccountResult;
  final ApiResult<ConnectAccountResponse> updateStripeConnectAccountResult;

  const ConnectedAccountState._({
    this.stripeAccountResult = const ApiResultInitial(),
    this.updateStripeConnectAccountResult = const ApiResultInitial(),
  });

  const ConnectedAccountState.initial() : this._();

  ConnectedAccountState copyWith({
    ApiResult<StripeAccount>? stripeAccountResult,
    ApiResult<ConnectAccountResponse>? updateStripeConnectAccountResult,
  }) {
    return ConnectedAccountState._(
      stripeAccountResult: stripeAccountResult ?? this.stripeAccountResult,
      updateStripeConnectAccountResult: updateStripeConnectAccountResult ?? this.updateStripeConnectAccountResult,
    );
  }

  @override
  List<Object?> get props => [stripeAccountResult, updateStripeConnectAccountResult];
}
