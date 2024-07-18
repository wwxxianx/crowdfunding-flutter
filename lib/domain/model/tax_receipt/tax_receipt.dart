// model TaxReceiptReports {
//   id             String @id @default(uuid())
//   user           User   @relation(fields: [userId], references: [id])
//   userId         String
//   receiptFileUrl String
//   year           Int

//   createdAt DateTime @default(now())

import 'package:json_annotation/json_annotation.dart';

part 'tax_receipt.g.dart';

@JsonSerializable()
class TaxReceipt {
  final String id;
  final String userId;
  final String receiptFileUrl;
  final String createdAt;

  const TaxReceipt({
    required this.id,
    required this.userId,
    required this.receiptFileUrl,
    required this.createdAt,
  });

  factory TaxReceipt.fromJson(Map<String, dynamic> json) =>
      _$TaxReceiptFromJson(json);

  Map<String, dynamic> toJson() => _$TaxReceiptToJson(this);
}
