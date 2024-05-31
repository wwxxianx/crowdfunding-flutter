import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:equatable/equatable.dart';

final class PurchaseGiftCardState extends Equatable {
  final String? userSearchQuery;
  final ApiResult<List<UserModel>> usersResult;
  final UserModel? selectedUser;
  final String? amountText;
  final String? messageText;

  // Error
  final String? userError;
  final String? amountError;
  final String? messageError;

  final ApiResult<void> createGiftCardResult;

  const PurchaseGiftCardState._({
    this.userSearchQuery,
    this.usersResult = const ApiResultInitial(),
    this.selectedUser,
    this.amountText,
    this.messageText,
    this.userError,
    this.amountError,
    this.messageError,
    this.createGiftCardResult = const ApiResultInitial(),
  });

  const PurchaseGiftCardState.initial() : this._();

  PurchaseGiftCardState copyWith({
    String? userSearchQuery,
    ApiResult<List<UserModel>>? usersResult,
    UserModel? selectedUser,
    String? amountText,
    String? messageText,
    String? userError,
    String? amountError,
    String? messageError,
    ApiResult<void>? createGiftCardResult,
  }) {
    return PurchaseGiftCardState._(
      userSearchQuery: userSearchQuery ?? this.userSearchQuery,
      usersResult: usersResult ?? this.usersResult,
      selectedUser: selectedUser,
      amountText: amountText ?? this.amountText,
      messageText: messageText ?? this.messageText,
      userError: userError,
      amountError: amountError,
      messageError: messageError,
      createGiftCardResult: createGiftCardResult ?? this.createGiftCardResult,
    );
  }

  @override
  List<Object?> get props => [
        userSearchQuery,
        usersResult,
        selectedUser,
        amountText,
        messageText,
        userError,
        amountError,
        messageError,
        createGiftCardResult,
      ];
}
