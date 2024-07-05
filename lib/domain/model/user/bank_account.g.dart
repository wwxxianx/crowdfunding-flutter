// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankAccount _$BankAccountFromJson(Map<String, dynamic> json) => BankAccount(
      id: json['id'] as String,
      userId: json['userId'] as String,
      detailsSubmitted: json['detailsSubmitted'] as bool,
      payoutsEnabled: json['payoutsEnabled'] as bool,
      chargesEnabled: json['chargesEnabled'] as bool,
      email: json['email'] as String?,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$BankAccountToJson(BankAccount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'detailsSubmitted': instance.detailsSubmitted,
      'payoutsEnabled': instance.payoutsEnabled,
      'chargesEnabled': instance.chargesEnabled,
      'email': instance.email,
      'error': instance.error,
    };
