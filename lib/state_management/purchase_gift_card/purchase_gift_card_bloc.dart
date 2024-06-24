import 'package:crowdfunding_flutter/common/utils/input_validator.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/payload/user/get_users_payload.dart';
import 'package:crowdfunding_flutter/data/service/payment/gift_card/create_gift_card_payment_intent_payload.dart';
import 'package:crowdfunding_flutter/data/service/payment/payment_service.dart';
import 'package:crowdfunding_flutter/domain/usecases/user/fetch_users.dart';
import 'package:crowdfunding_flutter/state_management/purchase_gift_card/purchase_gift_card_event.dart';
import 'package:crowdfunding_flutter/state_management/purchase_gift_card/purchase_gift_card_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class PurchaseGiftCardBloc
    extends Bloc<PurchaseGiftCardEvent, PurchaseGiftCardState>
    with InputValidator {
  final FetchUsers _fetchUsers;
  final PaymentService _paymentService;
  PurchaseGiftCardBloc({
    required FetchUsers fetchUsers,
    required PaymentService paymentService,
  })  : _fetchUsers = fetchUsers,
        _paymentService = paymentService,
        super(const PurchaseGiftCardState.initial()) {
    on<PurchaseGiftCardEvent>(_onEvent);
  }

  Future<void> _onEvent(
      PurchaseGiftCardEvent event, Emitter<PurchaseGiftCardState> emit) async {
    return switch (event) {
      final OnUserSearchQueryChanged e => _onSearchQueryChanged(e, emit),
      final OnSearchUsers e => _onSearchUsers(e, emit),
      final OnSelectUser e => _onSelectUser(e, emit),
      final OnMessageTextChanged e => _onMessageTextChanged(e, emit),
      final OnAmountTextChanged e => _onAmountTextChanged(e, emit),
      final OnValidateGiftCardData e => _onValidateGiftCardData(e, emit),
      final OnCreateGiftCardAndPayment e =>
        _onCreateGiftCardAndPayment(e, emit),
    };
  }

  Future<void> _onCreateGiftCardAndPayment(
    OnCreateGiftCardAndPayment event,
    Emitter<PurchaseGiftCardState> emit,
  ) async {
    emit(state.copyWith(
      createGiftCardResult: const ApiResultLoading(),
      selectedUser: state.selectedUser,
    ));
    final payload = CreateGiftCardPaymentIntentPayload(
      receiverId: state.selectedUser!.id,
      amount: int.parse(state.amountText!),
      message: state.messageText!,
    );
    final paymentIntentRes =
        await _paymentService.initGiftCardPaymentSheet(payload);
    paymentIntentRes.fold(
      (failure) {},
      (unit) async {
        final paymentRes = await _paymentService.presentPaymentSheet();
        paymentRes.fold(
          (l) => emit(state.copyWith(
              createGiftCardResult: ApiResultFailure(l.errorMessage))),
          (r) {
            emit(state.copyWith(
                createGiftCardResult: const ApiResultSuccess(Unit)));
            event.onSuccess();
          },
        );
      },
    );
  }

  void _onValidateGiftCardData(
    OnValidateGiftCardData event,
    Emitter<PurchaseGiftCardState> emit,
  ) {
    final userResult = state.selectedUser == null
        ? const InputValidationResult.fail("Gift card must have a receiver")
        : const InputValidationResult.success();
    final amountResult = state.amountText == null
        ? const InputValidationResult.fail("Please give an amount to your gift")
        : const InputValidationResult.success();
    final messageResult = validateStringWithMinMaxLength(
      title: "Blessing message",
      value: state.messageText,
      minLength: 10,
      maxLength: 1000,
    );
    final hasError = <InputValidationResult>[
      userResult,
      amountResult,
      messageResult,
    ].any((res) => !res.successful);
    if (hasError) {
      emit(state.copyWith(
        userError: userResult.errorMessage,
        amountError: amountResult.errorMessage,
        messageError: messageResult.errorMessage,
        selectedUser: state.selectedUser,
      ));
      return;
    }
    event.onSuccess();
  }

  void _onAmountTextChanged(
    OnAmountTextChanged event,
    Emitter<PurchaseGiftCardState> emit,
  ) {
    emit(state.copyWith(
        amountText: event.value, selectedUser: state.selectedUser));
  }

  void _onMessageTextChanged(
    OnMessageTextChanged event,
    Emitter<PurchaseGiftCardState> emit,
  ) {
    emit(state.copyWith(
        messageText: event.value, selectedUser: state.selectedUser));
  }

  void _onSelectUser(
    OnSelectUser event,
    Emitter<PurchaseGiftCardState> emit,
  ) {
    emit(state.copyWith(selectedUser: event.user));
  }

  Future<void> _onSearchUsers(
    OnSearchUsers event,
    Emitter<PurchaseGiftCardState> emit,
  ) async {
    final payload = GetUsersPayload(
      userName: state.userSearchQuery,
      email: state.userSearchQuery,
    );
    final res = await _fetchUsers.call(payload);
    res.fold(
      (failure) => null,
      (users) {
        emit(state.copyWith(
            usersResult: ApiResultSuccess(users),
            selectedUser: state.selectedUser));
      },
    );
  }

  void _onSearchQueryChanged(
    OnUserSearchQueryChanged event,
    Emitter<PurchaseGiftCardState> emit,
  ) {
    emit(state.copyWith(
        userSearchQuery: event.searchQuery, selectedUser: state.selectedUser));
  }
}
