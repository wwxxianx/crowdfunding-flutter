import 'package:json_annotation/json_annotation.dart';

part 'bank_account.g.dart';

@JsonSerializable()
class BankAccount {
  final String id;
  final String userId;
  final bool detailsSubmitted;
  final bool payoutsEnabled;
  final bool chargesEnabled;
  final String? email;
  final String? error;

  const BankAccount({
    required this.id,
    required this.userId,
    required this.detailsSubmitted,
    required this.payoutsEnabled,
    required this.chargesEnabled,
    this.email,
    this.error,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) =>
      _$BankAccountFromJson(json);

  Map<String, dynamic> toJson() => _$BankAccountToJson(this);
}
