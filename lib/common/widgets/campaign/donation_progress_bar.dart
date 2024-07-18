import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DonationProgressBar extends StatelessWidget {
  final double total;
  final double current;
  final double height;
  final bool showDonationStatusText;
  const DonationProgressBar({
    super.key,
    required this.current,
    required this.total,
    this.height = 10.0,
    this.showDonationStatusText = false,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = (current / total) > 1 ? 1.0 : current / total;
    String formattedTotal = NumberFormat('#,###').format(total);
    String formattedCurrent = NumberFormat('#,###').format(current);

    return Column(
      // mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Row(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "RM ${formattedCurrent} / RM ${formattedTotal}",
                style: CustomFonts.labelExtraSmall,
              ),
              // if (showDonationStatusText)
              //   Text(
              //     " (800 donations)",
              //     style: CustomFonts.titleExtraSmall,
              //   ),
            ],
          ),
        ),
        2.kH,
        Stack(
          children: [
            Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: const Color(0xFFF2F1F1),
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
            ),
            FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                height: height,
                decoration: BoxDecoration(
                  gradient: CustomColors.primaryGreenGradient,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
