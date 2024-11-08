// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignComment _$CampaignCommentFromJson(Map<String, dynamic> json) =>
    CampaignComment(
      id: json['id'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      comment: json['comment'] as String,
      createdAt: json['createdAt'] as String,
      replies: (json['replies'] as List<dynamic>?)
              ?.map((e) => CampaignComment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      parentId: json['parentId'] as String?,
    );

Map<String, dynamic> _$CampaignCommentToJson(CampaignComment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'comment': instance.comment,
      'createdAt': instance.createdAt,
      'parentId': instance.parentId,
      'replies': instance.replies,
    };
