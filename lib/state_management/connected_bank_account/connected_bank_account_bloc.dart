import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/payload/stripe/update_connect_account_payload.dart';
import 'package:crowdfunding_flutter/domain/usecases/stripe/fetch_connected_account.dart';
import 'package:crowdfunding_flutter/domain/usecases/stripe/update_connect_account.dart';
import 'package:crowdfunding_flutter/state_management/connected_bank_account/connected_bank_account_event.dart';
import 'package:crowdfunding_flutter/state_management/connected_bank_account/connected_bank_account_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class ConnectedAccountBloc
    extends Bloc<ConnectedAccountEvent, ConnectedAccountState> {
  final FetchConnectedAccount _fetchConnectedAccount;
  final UpdateConnectAccount _updateConnectAccount;
  ConnectedAccountBloc({
    required FetchConnectedAccount fetchConnectedAccount,
    required UpdateConnectAccount updateConnectAccount,
  })  : _fetchConnectedAccount = fetchConnectedAccount,
        _updateConnectAccount = updateConnectAccount,
        super(const ConnectedAccountState.initial()) {
    on<ConnectedAccountEvent>(_onEvent);
  }

  Future<void> _onEvent(
      ConnectedAccountEvent event, Emitter<ConnectedAccountState> emit) async {
    return switch (event) {
      final OnFetchConnectedAccount e => _onFetchConnectedAccount(e, emit),
      final OnUpdateConnectAccount e => _onUpdateConnectAccount(e, emit),
    };
  }

  Future<void> _onUpdateConnectAccount(
    OnUpdateConnectAccount event,
    Emitter<ConnectedAccountState> emit,
  ) async {
    emit(state.copyWith(updateStripeConnectAccountResult: const ApiResultLoading()));
    final payload = UpdateConnectAccountPayload(stripeConnectAccountId: event.stripeConnectAccountId);
    final res = await _updateConnectAccount.call(payload);
    res.fold(
      (failure) {
        emit(state.copyWith(updateStripeConnectAccountResult: ApiResultFailure(failure.errorMessage)));
      },
      (onboardLinkRes) {
        emit(state.copyWith(updateStripeConnectAccountResult: ApiResultSuccess(onboardLinkRes)));
        event.onSuccess(onboardLinkRes.onboardLink);
      },
    );
  }

  Future<void> _onFetchConnectedAccount(
    OnFetchConnectedAccount event,
    Emitter<ConnectedAccountState> emit,
  ) async {
    var logger = Logger();
    final connectedAccountId = event.stripeConnectAccountId;
    emit(state.copyWith(stripeAccountResult: const ApiResultLoading()));
    if (connectedAccountId == null || connectedAccountId.isEmpty) {
      // No account
      emit(state.copyWith(stripeAccountResult: const ApiResultInitial()));
      return;
    }
    final res = await _fetchConnectedAccount.call(connectedAccountId);
    res.fold(
      (l) {
        logger.w('Failed with ${l.errorMessage}');
      },
      (account) {
        logger.w(account);
        emit(state.copyWith(stripeAccountResult: ApiResultSuccess(account)));
      },
    );
  }
}
