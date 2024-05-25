import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_comment.dart';
import 'package:crowdfunding_flutter/presentation/campaign_details/tabs/about_tab.dart';
import 'package:crowdfunding_flutter/presentation/campaign_details/tabs/comment_tab.dart';
import 'package:crowdfunding_flutter/presentation/campaign_details/tabs/donation_tab.dart';
import 'package:crowdfunding_flutter/presentation/campaign_details/tabs/update_tab.dart';
import 'package:crowdfunding_flutter/state_management/campaign_details/campaign_details_bloc.dart';
import 'package:crowdfunding_flutter/state_management/campaign_details/campaign_details_event.dart';
import 'package:crowdfunding_flutter/state_management/campaign_details/campaign_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CampaignDetailsTabView extends StatefulWidget {
  final void Function(CampaignComment campaignComment) onReplyButtonPreesed;
  const CampaignDetailsTabView({
    super.key,
    required this.onReplyButtonPreesed,
  });

  @override
  State<CampaignDetailsTabView> createState() => _CampaignDetailsTabViewState();
}

class _CampaignDetailsTabViewState extends State<CampaignDetailsTabView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  static const tabs = [
    "About",
    "Donations",
    "Comments",
    "Updates",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: tabs.length,
      vsync: this,
    );

    // Listen to tab changes
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _handleTabIndexChange(_tabController.index);
      }
    });
  }

  @override
  void didUpdateWidget(CampaignDetailsTabView oldWidget) {
    super.didUpdateWidget(oldWidget);
    final currentTabIndex =
        context.read<CampaignDetailsBloc>().state.currentTabIndex;
    if (_tabController.index != currentTabIndex) {
      _tabController.animateTo(currentTabIndex);
    }
  }

  void _handleTabIndexChange(int index) {
    context.read<CampaignDetailsBloc>().add(OnTabIndexChanged(index));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildTabContent(int index, CampaignDetailsState state) {
    final campaignResult = state.campaignResult;
    switch (index) {
      case 0:
        return CampaignAboutTabContent();
      case 1:
        return const DonationTab();
      case 2:
        final List<CampaignComment> comments =
            (campaignResult is ApiResultSuccess<Campaign>)
                ? campaignResult.data.comments
                : [];
        return CampaignCommentTabContent(
          onReplyButtonPressed: widget.onReplyButtonPreesed,
          comments: comments,
        );
      case 3:
        return CampaignUpdateTabContent();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampaignDetailsBloc, CampaignDetailsState>(
      builder: (context, state) {
        var currentTabIndex = state.currentTabIndex;
        return Column(
          children: [
            TabBar(
              controller: _tabController,
              onTap: _handleTabIndexChange,
              labelPadding:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 12.0),
              tabs: tabs
                  .map(
                    (tab) => Text(
                      tab,
                      style: TextStyle(fontSize: 14.0),
                    ),
                  )
                  .toList(),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Container(
                // This key causes the AnimatedSwitcher to interpret this as a "new"
                // child each time the count changes, so that it will begin its animation
                // when the count changes.
                key: ValueKey<int>(currentTabIndex),
                child: _buildTabContent(currentTabIndex, state),
              ),
            ),
          ],
        );
      },
    );
  }
}
