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
  COMMUNITY_CHALLENGE_REWARD,
  SCAM,
  CAMPAIGN_STATUS_CHANGED,
  NEW_MATCHED_CAMPAIGN,
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

  NotificationType get typeEnum {
    try {
      return NotificationType.values.byName(type);
    } catch (e) {
      return NotificationType.CAMPAIGN_UPDATE;
    }
  }

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

  NotificationModel copyWith({
    String? id,
    String? type,
    String? title,
    String? description,
    bool? isRead,
    Map<String, dynamic>? metadata,
    UserModel? actor,
    String? entityId,
    String? createdAt,
    CampaignSummary? campaign,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      isRead: isRead ?? this.isRead,
      metadata: metadata ?? this.metadata,
      actor: actor ?? this.actor,
      entityId: entityId ?? this.entityId,
      createdAt: createdAt ?? this.createdAt,
      campaign: campaign ?? this.campaign,
    );
  }

  static final samples = [
    NotificationModel(
      id: '1',
      type: 'CAMPAIGN_UPDATE',
      title: 'title',
      isRead: false,
      description: 'description',
      actor: UserModel.sample,
      entityId: '123',
      createdAt: '2024-05-16T08:21:57.324Z',
    ),
    NotificationModel(
      id: '1',
      type: 'CAMPAIGN_UPDATE',
      title: 'title',
      isRead: false,
      description: 'description',
      actor: UserModel.sample,
      entityId: '123',
      createdAt: '2024-05-16T08:21:57.324Z',
    ),
    NotificationModel(
      id: '1',
      isRead: false,
      type: 'CAMPAIGN_UPDATE',
      title: 'A lover donated RM500 to your fundraiser!',
      entityId: '123',
      createdAt: '2024-05-16T08:21:57.324Z',
    ),
   NotificationModel(
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
