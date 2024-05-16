import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

enum NotificationType {
  campaignUpdate,
  campaignDonation,
  campaignComment,
  coin,
}

@JsonSerializable()
class Notification {
  final String id;
  final NotificationType type;
  final String title;
  final String description;
  final Map<String, dynamic>? meta;
  final UserModel actor;
  final String entityId;
  final String createdAt;

  const Notification({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    this.meta,
    required this.actor,
    required this.entityId,
    required this.createdAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}
