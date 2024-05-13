import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:crowdfunding_flutter/common/widgets/scaffold_mask.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class ReplyBottomSheet extends StatefulWidget {
  final VoidCallback onClose;
  final FocusNode focusNode;
  const ReplyBottomSheet({
    super.key,
    required this.onClose,
    required this.focusNode,
  });

  @override
  State<ReplyBottomSheet> createState() => _ReplyBottomSheetState();
}

class _ReplyBottomSheetState extends State<ReplyBottomSheet> {
  final replyTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        GestureDetector(
          onTap: widget.onClose,
          child: ScaffoldMask(),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.screenHorizontalPadding,
            vertical: 14.0,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Reply to: @Ellisa “How’s the funds?”",
                style: CustomFonts.bodyMedium.copyWith(
                  color: CustomColors.textGrey,
                ),
              ),
              4.kH,
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: CustomOutlinedTextfield(
                      controller: replyTextController,
                      focusNode: widget.focusNode,
                    ),
                  ),
                  8.kW,
                  IconButton(
                    onPressed: () {},
                    icon: const HeroIcon(HeroIcons.paperAirplane),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
