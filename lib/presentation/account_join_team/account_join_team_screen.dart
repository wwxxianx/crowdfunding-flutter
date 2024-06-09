import 'package:cached_network_image/cached_network_image.dart';
import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/string.dart';
import 'package:crowdfunding_flutter/common/widgets/avatar/avatar.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:flutter/material.dart';

class AccountJoinTeamScreen extends StatelessWidget {
  static const route = '/account-join-team';
  const AccountJoinTeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Join a team',
          style: CustomFonts.labelMedium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FeaturedOrganizationList(
              organizations: Organization.samples,
            ),
          ],
        ),
      ),
    );
  }
}

class FeaturedOrganizationList extends StatelessWidget {
  final List<Organization> organizations;
  const FeaturedOrganizationList({
    super.key,
    required this.organizations,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: Dimensions.screenHorizontalPadding),
          child: Text(
            'Our featured organization',
            style: CustomFonts.labelLarge,
          ),
        ),
        12.kH,
        SizedBox(
          height: 200,
          child: ListView.builder(
            padding: const EdgeInsets.only(
              left: Dimensions.screenHorizontalPadding,
            ),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: organizations.length,
            itemBuilder: (context, index) {
              final organization = organizations[index];
              return Container(
                margin: const EdgeInsets.only(right: 12),
                width: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.black),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      clipBehavior: Clip.none,
                      children: [
                        SizedBox(
                          height: 80,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: organization.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.4),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: -20,
                          child: Avatar(
                            imageUrl: organization.imageUrl,
                            size: 60,
                            border: Border.all(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, top: 20),
                      child: Text(
                        'Bill Gates Foundation OrganizationBill Gates Foundation Organization',
                        style: CustomFonts.labelMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 6),
                      child: Text(
                        'Join since ${organization.createdAt.toTime()}',
                        style: CustomFonts.bodySmall
                            .copyWith(color: CustomColors.textGrey),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
