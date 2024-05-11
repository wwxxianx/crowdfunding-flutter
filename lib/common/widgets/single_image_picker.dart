import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/avatar/avatar.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class SingleImagePicker extends StatefulWidget {
  final double size;
  const SingleImagePicker({
    super.key,
    this.size = 100,
  });

  @override
  State<SingleImagePicker> createState() => _SingleImagePickerState();
}

class _SingleImagePickerState extends State<SingleImagePicker> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Avatar(
          imageUrl: "",
          size: widget.size,
        ),
        Positioned(
          bottom: -10,
          child: IntrinsicWidth(
            child: CustomButton(
              borderRadius: BorderRadius.circular(100.0),
              height: 30,
              padding: const EdgeInsets.only(
                left: 6,
                right: 8,
                top: 4,
                bottom: 4,
              ),
              style: CustomButtonStyle.white,
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeroIcon(
                    HeroIcons.pencil,
                    size: 16,
                    style: HeroIconStyle.solid,
                  ),
                  4.kW,
                  const Text(
                    "Edit",
                    style: CustomFonts.labelExtraSmall,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
