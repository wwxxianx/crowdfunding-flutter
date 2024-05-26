import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomSheet extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final Widget child;
  final Widget? bottomAction;
  const CustomBottomSheet({
    super.key,
    this.padding = const EdgeInsets.only(
      top: 8,
      left: 20,
      right: 20,
    ),
    required this.child,
    this.bottomAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: padding,
              child: Column(
                children: [
                  20.kH,
                  child,
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: SvgPicture.asset(
                  "assets/icons/bottom-sheet-top-close-indicator.svg"),
            ),
          ),
          if (bottomAction != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: CustomColors.divider),
                  ),
                ),
                child: bottomAction,
              ),
            ),
        ],
      ),
    );
  }
}
