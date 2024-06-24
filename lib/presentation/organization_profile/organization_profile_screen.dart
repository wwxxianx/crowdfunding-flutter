import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/avatar/avatar.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:crowdfunding_flutter/presentation/organization_profile/tabs/organization_profile_campaigns_tab.dart';
import 'package:crowdfunding_flutter/presentation/organization_profile/widgets/organization_app_bar.dart';
import 'package:crowdfunding_flutter/state_management/organization_profile/organization_profile_bloc.dart';
import 'package:crowdfunding_flutter/state_management/organization_profile/organization_profile_event.dart';
import 'package:crowdfunding_flutter/state_management/organization_profile/organization_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:logger/logger.dart';

class OrganizationProfileScreen extends StatefulWidget {
  static const route = '/organization-profile/:organizationId';
  static generateRoute({required String organizationId}) =>
      '/organization-profile/$organizationId';
  final String organizationId;
  const OrganizationProfileScreen({
    super.key,
    required this.organizationId,
  });

  @override
  State<OrganizationProfileScreen> createState() =>
      _OrganizationProfileScreenState();
}

class _OrganizationProfileScreenState extends State<OrganizationProfileScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final ScrollController _scrollController;
  late final OrganizationProfileBloc _organizationProfileBloc;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    _organizationProfileBloc =
        OrganizationProfileBloc(fetchOrganization: serviceLocator())
          ..add(OnFetchOrganization(organizationId: widget.organizationId));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildUnverfiedContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.screenHorizontalPadding,
        vertical: Dimensions.screenHorizontalPadding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: CustomColors.amber50,
              border: Border.all(color: CustomColors.amber500),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeroIcon(
                      HeroIcons.shieldExclamation,
                      style: HeroIconStyle.solid,
                      size: 20,
                      color: CustomColors.amber700,
                    ),
                    4.kW,
                    Flexible(
                      child: Text(
                        "This organization is still being verified.",
                        style: CustomFonts.labelMedium
                            .copyWith(color: CustomColors.amber700),
                      ),
                    ),
                  ],
                ),
                6.kH,
                Text(
                  "Our team is still verifying the organization. You can join once it’s verified. Don’t worry, it won’t take too long.",
                  style: CustomFonts.bodySmall
                      .copyWith(color: CustomColors.amber700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _organizationProfileBloc,
      child: Scaffold(
        body: BlocBuilder<OrganizationProfileBloc, OrganizationProfileState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<OrganizationProfileBloc>().add(
                    OnFetchOrganization(organizationId: widget.organizationId));
              },
              child: CustomScrollView(
                controller: _scrollController,
                slivers: <Widget>[
                  OrganizationAppBar(
                    tabController: _tabController,
                    scrollController: _scrollController,
                    organizationId: widget.organizationId,
                  ),
                  SliverFillRemaining(
                    child: BlocBuilder<OrganizationProfileBloc,
                        OrganizationProfileState>(
                      builder: (context, state) {
                        final organizationResult = state.organizationResult;
                        if (organizationResult
                            is ApiResultSuccess<Organization>) {
                          if (!organizationResult.data.isVerified) {
                            return _buildUnverfiedContent();
                          }
                          return TabBarView(
                            controller: _tabController,
                            children: [
                              OrganizationCampaignsTabContent(),
                              Center(
                                child: Text('Profile tab'),
                              ),
                              Center(
                                child: Text('Campaigns tab'),
                              ),
                            ],
                          );
                        }
                        // Loading
                        return Text('loading...');
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
