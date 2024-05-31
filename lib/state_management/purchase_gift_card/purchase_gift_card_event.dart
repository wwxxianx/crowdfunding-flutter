import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:flutter/material.dart';

@immutable
sealed class PurchaseGiftCardEvent {
  const PurchaseGiftCardEvent();
}

final class OnUserSearchQueryChanged extends PurchaseGiftCardEvent {
  final String searchQuery;

  const OnUserSearchQueryChanged({required this.searchQuery});
}

final class OnSearchUsers extends PurchaseGiftCardEvent {}

final class OnSelectUser extends PurchaseGiftCardEvent {
  final UserModel? user;
  const OnSelectUser({required this.user});
}

final class OnAmountTextChanged extends PurchaseGiftCardEvent {
  final String value;
  const OnAmountTextChanged({required this.value});
}

final class OnMessageTextChanged extends PurchaseGiftCardEvent {
  final String value;
  const OnMessageTextChanged({required this.value});
}

final class OnValidateGiftCardData extends PurchaseGiftCardEvent {
  final VoidCallback onSuccess;

  const OnValidateGiftCardData({required this.onSuccess});
}

final class OnCreateGiftCardAndPayment extends PurchaseGiftCardEvent {
  final VoidCallback onSuccess;

  const OnCreateGiftCardAndPayment({required this.onSuccess});
}
