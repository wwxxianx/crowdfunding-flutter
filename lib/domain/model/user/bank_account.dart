import 'package:json_annotation/json_annotation.dart';

part 'bank_account.g.dart';

@JsonSerializable()
class BankAccount {
  final String id;
  final bool detailsSubmitted;
  final bool payoutsEnabled;
  final bool chargesEnabled;
  final String? email;
  final String? error;

  const BankAccount({
    required this.id,
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

@JsonSerializable()
class UserBankAccount extends BankAccount {
  final String userId;

  const UserBankAccount({
    required super.id,
    required super.detailsSubmitted,
    required super.payoutsEnabled,
    required super.chargesEnabled,
    super.email,
    super.error,
    required this.userId,
  }) : super();

  factory UserBankAccount.fromJson(Map<String, dynamic> json) =>
      _$UserBankAccountFromJson(json);

  Map<String, dynamic> toJson() => _$UserBankAccountToJson(this);
}

@JsonSerializable()
class OrganizationBankAccount extends BankAccount {
  final String organizationId;

  const OrganizationBankAccount({
    required super.id,
    required super.detailsSubmitted,
    required super.payoutsEnabled,
    required super.chargesEnabled,
    super.email,
    super.error,
    required this.organizationId,
  });

  factory OrganizationBankAccount.fromJson(Map<String, dynamic> json) => _$OrganizationBankAccountFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationBankAccountToJson(this);
}