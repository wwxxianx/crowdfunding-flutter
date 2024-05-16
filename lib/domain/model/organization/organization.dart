import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'organization.g.dart';

@JsonSerializable()
class Organization {
  final String id;
  final String name;
  final String? description;
  final String? imageUrl;
  final String invitationCode;
  final bool isVerified;
  final List<UserModel> members;
  final String createdAt;
  final String updatedAt;
  final List<Campaign> campaigns;

  const Organization({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    required this.invitationCode,
    required this.isVerified,
    required this.members,
    required this.createdAt,
    required this.updatedAt,
    this.campaigns = const [],
  });

  factory Organization.fromJson(Map<String, dynamic> json) =>
      _$OrganizationFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationToJson(this);
}
