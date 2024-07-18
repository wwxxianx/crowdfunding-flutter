// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tax_receipt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaxReceipt _$TaxReceiptFromJson(Map<String, dynamic> json) => TaxReceipt(
      id: json['id'] as String,
      userId: json['userId'] as String,
      receiptFileUrl: json['receiptFileUrl'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$TaxReceiptToJson(TaxReceipt instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'receiptFileUrl': instance.receiptFileUrl,
      'createdAt': instance.createdAt,
    };
