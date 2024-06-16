import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/container/custom_bottom_sheet.dart';
import 'package:crowdfunding_flutter/common/widgets/container/selectable_container.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:flutter/material.dart';

class CancelCollaborationBottomSheet extends StatefulWidget {
  const CancelCollaborationBottomSheet({super.key});

  @override
  State<CancelCollaborationBottomSheet> createState() =>
      _CancelCollaborationBottomSheetState();
}

class _CancelCollaborationBottomSheetState
    extends State<CancelCollaborationBottomSheet> {
  static const List<String> reasons = [
    'The organization is not helping at all.',
    'I can manage my campaign and don’t need help anymore.',
    'I don’t see any improvements of my campaign.',
  ];
  String selectedReason = reasons.first;
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDraggableSheet(
      initialChildSize: 0.95,
      footer: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.screenHorizontalPadding,
          vertical: 10,
        ),
        child: SizedBox(
          width: double.infinity,
          child: CustomButton(
            onPressed: () {},
            child: const Text('Submit and Cancel Collaboration'),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.screenHorizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Why you cancel this collaboration?',
              style: CustomFonts.labelMedium,
            ),
            4.kH,
            Text(
              'Please select the reason that make you decide to cancel this collaboration',
              style: CustomFonts.bodySmall.copyWith(
                color: CustomColors.textGrey,
              ),
            ),
            20.kH,
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: reasons.length,
              itemBuilder: (context, index) {
                return SelectableContainer(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  margin: const EdgeInsets.only(bottom: 8),
                  isSelected: selectedReason == reasons[index],
                  onTap: () {
                    setState(() {
                      selectedReason = reasons[index];
                      textController.clear();
                    });
                  },
                  child: Text(reasons[index]),
                );
              },
            ),
            12.kH,
            CustomOutlinedTextfield(
              label: 'Other reason:',
              hintText: 'I decided to manage on my own.',
              controller: textController,
              onTap: () {
                setState(() {
                  selectedReason = '';
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
