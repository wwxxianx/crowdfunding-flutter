import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/payload/user/tax_receipt/get_tax_receipt_payload.dart';
import 'package:crowdfunding_flutter/domain/usecases/user/donation/fetch_user_donations.dart';
import 'package:crowdfunding_flutter/domain/usecases/user/tax_receipt/fetch_tax_receipt.dart';
import 'package:crowdfunding_flutter/state_management/user_donations/user_donations_event.dart';
import 'package:crowdfunding_flutter/state_management/user_donations/user_donations_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDonationsBloc extends Bloc<UserDonationsEvent, UserDonationsState> {
  final FetchUserDonations _fetchUserDonations;
  final FetchTaxReceipt _fetchTaxReceipt;
  UserDonationsBloc({
    required FetchUserDonations fetchUserDonations,
    required FetchTaxReceipt fetchTaxReceipt,
  })  : _fetchUserDonations = fetchUserDonations,
        _fetchTaxReceipt = fetchTaxReceipt,
        super(const UserDonationsState.initial()) {
    on<UserDonationsEvent>(_onEvent);
  }

  Future<void> _onEvent(
      UserDonationsEvent event, Emitter<UserDonationsState> emit) async {
    return switch (event) {
      final OnFetchUserDonations e => _onFetchUserDonations(e, emit),
      final OnFetchTaxReceipt e => _onFetchTaxReceipt(e, emit),
    };
  }

  Future<void> _onFetchTaxReceipt(
      OnFetchTaxReceipt event, Emitter<UserDonationsState> emit) async {
    emit(state.copyWith(taxReceiptResult: const ApiResultLoading()));
    final payload = GetTaxReceiptPayload(year: event.year);
    final res = await _fetchTaxReceipt.call(payload);
    res.fold(
      (failure) => emit(state.copyWith(
          taxReceiptResult: ApiResultFailure(failure.errorMessage))),
      (data) {
        emit(state.copyWith(taxReceiptResult: ApiResultSuccess(data)));
        event.onSuccess(data);
      },
    );
  }

  Future<void> _onFetchUserDonations(
      OnFetchUserDonations event, Emitter<UserDonationsState> emit) async {
    emit(state.copyWith(userDonationsResult: const ApiResultLoading()));
    final res = await _fetchUserDonations.call(NoPayload());
    res.fold(
      (failure) => emit(state.copyWith(
          userDonationsResult: ApiResultFailure(failure.errorMessage))),
      (data) =>
          emit(state.copyWith(userDonationsResult: ApiResultSuccess(data))),
    );
  }
}
