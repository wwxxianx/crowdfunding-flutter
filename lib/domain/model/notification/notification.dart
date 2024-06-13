// ignore_for_file: constant_identifier_names

import 'package:crowdfunding_flutter/domain/model/campaign/campaign_donation.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

enum NotificationType {
  CAMPAIGN_UPDATE,
  CAMPAIGN_DONATION,
  CAMPAIGN_COMMENT,
  COIN,
}

@JsonSerializable()
class NotificationModel {
  final String id;
  final String type;
  final String title;
  final String? description;
  final bool isRead;
  final Map<String, dynamic>? metadata;
  final UserModel? actor;
  final String entityId;
  final String createdAt;
  final CampaignSummary? campaign;

  const NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.isRead,
    this.description,
    this.metadata,
    this.actor,
    required this.entityId,
    required this.createdAt,
    this.campaign,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  static final samples = [
    const NotificationModel(
      id: '1',
      type: 'CAMPAIGN_UPDATE',
      title: 'title',
      isRead: false,
      description: 'description',
      actor: UserModel.sample,
      entityId: '123',
      createdAt: '2024-05-16T08:21:57.324Z',
    ),
    const NotificationModel(
      id: '1',
      type: 'CAMPAIGN_UPDATE',
      title: 'title',
      isRead: false,
      description: 'description',
      actor: UserModel.sample,
      entityId: '123',
      createdAt: '2024-05-16T08:21:57.324Z',
    ),
    const NotificationModel(
      id: '1',
      isRead: false,
      type: 'CAMPAIGN_UPDATE',
      title: 'A lover donated RM500 to your fundraiser!',
      entityId: '123',
      createdAt: '2024-05-16T08:21:57.324Z',
    ),
    const NotificationModel(
      id: '1',
      isRead: false,
      type: 'CAMPAIGN_UPDATE',
      title: 'A new comment to your fundraiser “Green Initiative”.',
      description: "Comment: “How can i donate to your fundraiser?”",
      entityId: '123',
      createdAt: '2024-05-16T08:21:57.324Z',
    ),
  ];
}
