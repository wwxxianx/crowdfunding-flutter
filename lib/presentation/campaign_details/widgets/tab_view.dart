import 'package:crowdfunding_flutter/presentation/campaign_details/widgets/about_tab.dart';
import 'package:crowdfunding_flutter/presentation/campaign_details/widgets/comment_tab.dart';
import 'package:crowdfunding_flutter/presentation/campaign_details/widgets/update_tab.dart';
import 'package:flutter/material.dart';

class CampaignDetailsTabView extends StatefulWidget {
  const CampaignDetailsTabView({super.key});

  @override
  State<CampaignDetailsTabView> createState() => _CampaignDetailsTabViewState();
}

class _CampaignDetailsTabViewState extends State<CampaignDetailsTabView> {
  int _currentTabIndex = 0;
  static const tabs = [
    "About",
    "Donations",
    "Comments",
    "Updates",
  ];

  void _handleTabIndexChange(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }

  Widget _buildTabContent() {
    switch (_currentTabIndex) {
      case 0:
        return CampaignAboutTabContent();
      case 1:
        return Text("Donations");
      case 2:
        return CampaignCommentTabContent();
      case 3:
        return CampaignUpdateTabContent();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.min,
      children: [
        DefaultTabController(
          length: tabs.length,
          child: TabBar(
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
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: Container(
            key: ValueKey<int>(_currentTabIndex),
            child: _buildTabContent(),
          ),
          // Text(
          //   '${_currentTabIndex}',
          //   // This key causes the AnimatedSwitcher to interpret this as a "new"
          //   // child each time the count changes, so that it will begin its animation
          //   // when the count changes.
          //   key: ValueKey<int>(_currentTabIndex),
          //   style: Theme.of(context).textTheme.headlineMedium,
          // ),
        ),
      ],
    );
  }
}
