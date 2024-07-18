import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/avatar/avatar.dart';
import 'package:crowdfunding_flutter/common/widgets/skeleton.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:crowdfunding_flutter/presentation/account/account_screen.dart';
import 'package:crowdfunding_flutter/presentation/edit_organization/edit_organization_screen.dart';
import 'package:crowdfunding_flutter/state_management/organization_profile/organization_profile_bloc.dart';
import 'package:crowdfunding_flutter/state_management/organization_profile/organization_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' as fp;
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';

class OrganizationAppBar extends StatefulWidget {
  final String organizationId;
  final TabController tabController;
  final ScrollController scrollController;
  const OrganizationAppBar({
    super.key,
    required this.organizationId,
    required this.tabController,
    required this.scrollController,
  });

  @override
  State<OrganizationAppBar> createState() => _OrganizationAppBarState();
}

class _OrganizationAppBarState extends State<OrganizationAppBar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _positionAnimation;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_scrollListener);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _positionAnimation =
        Tween<Offset>(begin: const Offset(0, 30), end: const Offset(0, 0))
            .animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  void _navigateToEditScreen(ApiResult<Organization> organizationResult) {
    if (organizationResult is ApiResultSuccess<Organization>) {
      context.push(
        EditOrganizationScreen.generateRoute(
            organizationId: widget.organizationId),
        extra: organizationResult.data,
      );
      return;
    }
    context.push(EditOrganizationScreen.generateRoute(
        organizationId: widget.organizationId));
  }

  void _scrollListener() {
    final scrollOffset = widget.scrollController.offset;
    final animationValue = (scrollOffset / 380).clamp(0.0, 1.0);
    _animationController.value = animationValue;
  }

  Widget _buildAvatarImage(ApiResult<Organization> organizationResult) {
    if (organizationResult is ApiResultSuccess<Organization>) {
      return ClipOval(
        child: Avatar(
          imageUrl: organizationResult.data.imageUrl,
          placeholder: organizationResult.data.name[0],
        ),
      );
    }
    return const Skeleton(
      radius: 100,
    );
  }

  Widget _buildTeamRow(ApiResult<Organization> organizationResult) {
    if (organizationResult is ApiResultSuccess<Organization>) {
      if (organizationResult.data.members != null &&
          organizationResult.data.members!.isNotEmpty) {
        return Stack(
          children: organizationResult.data.members!.mapWithIndex((t, index) {
            final member = organizationResult.data.members![index];
            return Transform.translate(
              offset: Offset(index * 30, 0),
              child: Avatar(
                imageUrl: member.profileImageUrl,
                placeholder: member.fullName[0],
                border: Border.all(color: Colors.white),
                size: 40,
              ),
            );
          }).toList(),
        );
      }
    }
    return const Skeleton(
      radius: 100,
      width: 40,
      height: 40,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrganizationProfileBloc, OrganizationProfileState>(
      builder: (context, state) {
        final organizationResult = state.organizationResult;
        return SliverAppBar(
          pinned: true,
          snap: false,
          floating: false,
          expandedHeight: 290.0,
          bottom: ColoredTabBar(
            color: Colors.white,
            tabBar: TabBar(
              controller: widget.tabController,
              tabs: [
                Tab(
                  text: 'Community',
                ),
                Tab(
                  text: 'Profile',
                ),
                Tab(
                  text: 'Campaigns',
                ),
              ],
            ),
          ),
          backgroundColor: Color(0xFF384d60),
          leading: IconButton(
            icon: const HeroIcon(
              HeroIcons.arrowLeft,
              color: Colors.white,
            ),
            onPressed: () {
              context.go('/account');
            },
          ),
          actions: [
            IconButton(
              icon: const HeroIcon(
                HeroIcons.pencilSquare,
                color: Colors.white,
              ),
              onPressed: () {
                _navigateToEditScreen(organizationResult);
              },
            ),
          ],
          centerTitle: true,
          title: AnimatedBuilder(
            animation: _opacityAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _opacityAnimation.value,
                child: Transform.translate(
                  offset: _positionAnimation.value,
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: _buildAvatarImage(organizationResult),
                  ),
                ),
              );
            },
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/organization-image-sample.png',
                  fit: BoxFit.cover,
                ),
                Container(
                  color: Colors.black.withOpacity(0.44),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 60),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 66,
                          height: 66,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: _buildAvatarImage(organizationResult),
                        ),
                        8.kH,
                        Row(
                          children: [
                            Text(
                              (organizationResult
                                      is ApiResultSuccess<Organization>)
                                  ? organizationResult.data.name
                                  : "",
                              style: CustomFonts.labelLarge
                                  .copyWith(fontSize: 18, color: Colors.white),
                            ),
                            4.kW,
                            const HeroIcon(
                              HeroIcons.checkBadge,
                              color: Colors.white,
                              style: HeroIconStyle.solid,
                            ),
                          ],
                        ),
                        12.kH,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Our team:',
                              style: CustomFonts.labelSmall
                                  .copyWith(color: Colors.white),
                            ),
                            6.kH,
                          ],
                        ),
                        _buildTeamRow(organizationResult),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ColoredTabBar extends Container implements PreferredSizeWidget {
  final Color color;
  final TabBar tabBar;

  ColoredTabBar({
    required this.color,
    required this.tabBar,
  });

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) => Container(
        color: color,
        child: tabBar,
      );
}
