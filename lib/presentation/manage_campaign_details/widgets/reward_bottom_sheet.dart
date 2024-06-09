import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/container/custom_bottom_sheet.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class RewardBottomSheet extends StatefulWidget {
  const RewardBottomSheet({super.key});

  @override
  State<RewardBottomSheet> createState() => _RewardBottomSheetState();
}

class _RewardBottomSheetState extends State<RewardBottomSheet> {
  late TextEditingController rewardTextController;
  var selectedReward = 0.01;
  final rewardRecommendationList = <double>[0.01, 0.05, 0.1];

  @override
  void initState() {
    super.initState();
    rewardTextController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    rewardTextController.dispose();
  }

  String getRewardText() {
    if (rewardTextController.text.isNotEmpty) {
      final reward = int.parse(rewardTextController.text);
      return (100 * (reward / 100)).toString();
    }
    return (100 * selectedReward).toString();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 250,
          maxHeight: MediaQuery.of(context).size.height / 2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "A way to thank the team!",
              style: CustomFonts.labelMedium,
            ),
            2.kH,
            Text(
              "Give some reward to your team for their support and contributions",
              style: CustomFonts.bodySmall.copyWith(
                color: CustomColors.textGrey,
              ),
            ),
            8.kH,
            Text(
              "For each RM100 donation received, give RM${getRewardText()} to my team.",
              style: CustomFonts.labelSmall.copyWith(
                color: CustomColors.textGrey,
              ),
            ),
            6.kH,
            Row(
              children: [
                RewardButton(
                  rewardValue: rewardRecommendationList[0],
                  onPressed: () {
                    setState(() {
                      selectedReward = rewardRecommendationList[0];
                    });
                  },
                  isSelected: selectedReward == rewardRecommendationList[0],
                ),
                20.kW,
                RewardButton(
                  rewardValue: rewardRecommendationList[1],
                  onPressed: () {
                    setState(() {
                      selectedReward = rewardRecommendationList[1];
                    });
                  },
                  isSelected: selectedReward == rewardRecommendationList[1],
                ),
                20.kW,
                RewardButton(
                  rewardValue: rewardRecommendationList[2],
                  onPressed: () {
                    setState(() {
                      selectedReward = rewardRecommendationList[2];
                    });
                  },
                  isSelected: selectedReward == rewardRecommendationList[2],
                ),
              ],
            ),
            CustomOutlinedTextfield(
              controller: rewardTextController,
              inputFormatters: [
                // Can not start with 0
                // FilteringTextInputFormatter.deny(RegExp(r'^0')),
                // // Only accept digit
                // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]?$')),
                FilteringTextInputFormatter.digitsOnly,
              ],
              contentPadding: const EdgeInsets.only(
                left: 12,
                right: 8,
                top: 8,
                bottom: 8,
              ),
              keyboardType: TextInputType.number,
              suffixIcon: const Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "%",
                    style: CustomFonts.labelSmall,
                  ),
                ],
              ),
              textAlign: TextAlign.end,
              label: "Reward",
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: () {},
                    child: Text("Send my help request"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RewardButton extends StatelessWidget {
  final double rewardValue;
  final VoidCallback onPressed;
  final bool isSelected;
  const RewardButton({
    super.key,
    required this.rewardValue,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              color:
                  isSelected ? CustomColors.containerLightGreen : Colors.white,
              border: Border.all(
                color: isSelected
                    ? CustomColors.accentGreen
                    : CustomColors.containerBorderGrey,
              ),
              borderRadius: BorderRadius.circular(6),
              boxShadow: isSelected ? CustomColors.containerGreenShadow : null,
            ),
            child: Center(
              child: Text(
                "${(rewardValue * 100).toInt().toString()}%",
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color:
                        isSelected ? CustomColors.accentGreen : Colors.black38,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
