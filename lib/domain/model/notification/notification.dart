import 'package:crowdfunding_flutter/domain/model/image/image_model.dart';
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
class NotificationModel {
  final String id;
  final NotificationType type;
  final String title;
  final String? description;
  final Map<String, dynamic>? meta;
  final UserModel? actor;
  final String entityId;
  final String createdAt;
  final String? actorImageUrl;
  final String? campaignImageUrl;
  final String? coinEarned;

  const NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    this.description,
    this.meta,
    this.actor,
    required this.entityId,
    required this.createdAt,
    this.actorImageUrl,
    this.campaignImageUrl,
    this.coinEarned,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  static final samples = [
    NotificationModel(
      id: '1',
      type: NotificationType.campaignUpdate,
      title: 'title',
      description: 'description',
      actor: UserModel.sample,
      entityId: '123',
      createdAt: '2024-05-16T08:21:57.324Z',
      actorImageUrl: ImageModel.sample.imageUrl,
      campaignImageUrl: ImageModel.sample.imageUrl,
    ),
    const NotificationModel(
      id: '1',
      type: NotificationType.coin,
      title: 'title',
      description: 'description',
      actor: UserModel.sample,
      entityId: '123',
      createdAt: '2024-05-16T08:21:57.324Z',
      coinEarned: '24',
    ),
    const NotificationModel(
      id: '1',
      type: NotificationType.campaignDonation,
      title: 'A lover donated RM500 to your fundraiser!',
      entityId: '123',
      createdAt: '2024-05-16T08:21:57.324Z',
    ),
    const NotificationModel(
      id: '1',
      type: NotificationType.campaignComment,
      title: 'A new comment to your fundraiser “Green Initiative”.',
      description: "Comment: “How can i donate to your fundraiser?”",
      entityId: '123',
      createdAt: '2024-05-16T08:21:57.324Z',
    ),
  ];
}
