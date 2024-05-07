import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';

class CustomTab extends StatelessWidget {
  final List<Widget> tabs;
  final void Function(int)? onTabItemChange;
  const CustomTab({
    super.key,
    required this.tabs,
    required this.onTabItemChange,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          child: IntrinsicWidth(
            child: Container(
              height: 40,
              padding: const EdgeInsets.all(4.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: Color(0xFFF1F9F2),
              ),
              child: TabBar(
                onTap: onTabItemChange,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 3.0,
                      offset: const Offset(0, 1),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 2.0,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                labelColor: CustomColors.fontBlack,
                unselectedLabelColor: Colors.black54,
                tabs: tabs,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TabItem extends StatelessWidget {
  final String title;
  final Widget? prefixIcon;
  const TabItem({
    super.key,
    required this.title,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (prefixIcon != null) prefixIcon!,
          if (prefixIcon != null) 4.kW,
          Text(
            title,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}