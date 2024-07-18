import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/model/image/image_model.dart';
import 'package:crowdfunding_flutter/domain/model/user/bank_account.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'organization.g.dart';

@JsonSerializable()
class Organization {
  final String id;
  final String name;
  final String email;
  final String? slogan;
  final String contactPhoneNumber;
  final bool isVerified;
  final String imageUrl;
  final String invitationCode;
  final List<UserModel>? members;
  final String createdAt;
  final String updatedAt;
  final List<Campaign>? campaigns;
  final UserModel createdBy;
  final OrganizationBankAccount? bankAccount;

  const Organization({
    required this.id,
    required this.name,
    required this.email,
    this.slogan,
    required this.imageUrl,
    required this.contactPhoneNumber,
    required this.invitationCode,
    required this.isVerified,
    required this.members,
    required this.createdAt,
    required this.updatedAt,
    this.campaigns = const [],
    required this.createdBy,
    this.bankAccount,
  });

  factory Organization.fromJson(Map<String, dynamic> json) =>
      _$OrganizationFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationToJson(this);

  static final samples = [
    Organization(
      id: "1",
      name: "My NPO",
      imageUrl: ImageModel.sample.imageUrl,
      email: "7J9qH@example.com",
      contactPhoneNumber: "1234567890",
      invitationCode: "123456",
      isVerified: true,
      members: [
        UserModel.sample,
      ],
      createdBy: UserModel.sample,
      createdAt: "2022-01-01",
      updatedAt: "2022-01-01",
    ),
    Organization(
      id: "1",
      name: "My NPO",
      imageUrl: ImageModel.sample.imageUrl,
      email: "7J9qH@example.com",
      contactPhoneNumber: "1234567890",
      invitationCode: "123456",
      isVerified: false,
      members: [
        UserModel.sample,
      ],
      createdBy: UserModel.sample,
      createdAt: "2022-01-01",
      updatedAt: "2022-01-01",
    ),
    Organization(
      id: "1",
      name: "My NPO",
      imageUrl: ImageModel.sample.imageUrl,
      email: "7J9qH@example.com",
      contactPhoneNumber: "1234567890",
      invitationCode: "123456",
      isVerified: false,
      members: [
        UserModel.sample,
      ],
      createdBy: UserModel.sample,
      createdAt: "2022-01-01",
      updatedAt: "2022-01-01",
    ),
  ];
}
