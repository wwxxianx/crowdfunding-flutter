import 'package:crowdfunding_flutter/domain/model/tax_receipt/tax_receipt.dart';
import 'package:flutter/material.dart';

@immutable
sealed class UserDonationsEvent {
  const UserDonationsEvent();
}

final class OnFetchUserDonations extends UserDonationsEvent {}

final class OnFetchTaxReceipt extends UserDonationsEvent {
  final int year;
  final void Function(TaxReceipt data) onSuccess;

  const OnFetchTaxReceipt({required this.year, required this.onSuccess,});
}
