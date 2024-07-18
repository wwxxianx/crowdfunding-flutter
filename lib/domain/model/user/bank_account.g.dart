// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankAccount _$BankAccountFromJson(Map<String, dynamic> json) => BankAccount(
      id: json['id'] as String,
      detailsSubmitted: json['detailsSubmitted'] as bool,
      payoutsEnabled: json['payoutsEnabled'] as bool,
      chargesEnabled: json['chargesEnabled'] as bool,
      email: json['email'] as String?,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$BankAccountToJson(BankAccount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'detailsSubmitted': instance.detailsSubmitted,
      'payoutsEnabled': instance.payoutsEnabled,
      'chargesEnabled': instance.chargesEnabled,
      'email': instance.email,
      'error': instance.error,
    };

UserBankAccount _$UserBankAccountFromJson(Map<String, dynamic> json) =>
    UserBankAccount(
      id: json['id'] as String,
      detailsSubmitted: json['detailsSubmitted'] as bool,
      payoutsEnabled: json['payoutsEnabled'] as bool,
      chargesEnabled: json['chargesEnabled'] as bool,
      email: json['email'] as String?,
      error: json['error'] as String?,
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$UserBankAccountToJson(UserBankAccount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'detailsSubmitted': instance.detailsSubmitted,
      'payoutsEnabled': instance.payoutsEnabled,
      'chargesEnabled': instance.chargesEnabled,
      'email': instance.email,
      'error': instance.error,
      'userId': instance.userId,
    };

OrganizationBankAccount _$OrganizationBankAccountFromJson(
        Map<String, dynamic> json) =>
    OrganizationBankAccount(
      id: json['id'] as String,
      detailsSubmitted: json['detailsSubmitted'] as bool,
      payoutsEnabled: json['payoutsEnabled'] as bool,
      chargesEnabled: json['chargesEnabled'] as bool,
      email: json['email'] as String?,
      error: json['error'] as String?,
      organizationId: json['organizationId'] as String,
    );

Map<String, dynamic> _$OrganizationBankAccountToJson(
        OrganizationBankAccount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'detailsSubmitted': instance.detailsSubmitted,
      'payoutsEnabled': instance.payoutsEnabled,
      'chargesEnabled': instance.chargesEnabled,
      'email': instance.email,
      'error': instance.error,
      'organizationId': instance.organizationId,
    };
