import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/container/selectable_container.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

enum AgeGroup {
  baby,
  child,
  youngAdult,
  midAndAgedAdult,
}

extension AgeGroupExtension on AgeGroup {
  String getAgeText() {
    switch (this) {
      case AgeGroup.baby:
        return "0-2";
      case AgeGroup.child:
        return "3-16";
      case AgeGroup.youngAdult:
        return "17-30";
      case AgeGroup.midAndAgedAdult:
        return "31+";
    }
  }

  String getAgeTitle() {
    switch (this) {
      case AgeGroup.baby:
        return "Baby";
      case AgeGroup.child:
        return "Child";
      case AgeGroup.youngAdult:
        return "Young adult";
      case AgeGroup.midAndAgedAdult:
        return "Mid/old-aged adult";
    }
  }
}

class BeneficiaryForm extends StatefulWidget {
  final VoidCallback onPreviousPage;
  final VoidCallback onNextPage;
  const BeneficiaryForm({
    super.key,
    required this.onNextPage,
    required this.onPreviousPage,
  });

  @override
  State<BeneficiaryForm> createState() => _BeneficiaryFormState();
}

class _BeneficiaryFormState extends State<BeneficiaryForm> {
  final amountController = TextEditingController();
  AgeGroup selectedAge = AgeGroup.baby;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.onPreviousPage();
        return false;
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: Dimensions.screenHorizontalPadding,
          right: Dimensions.screenHorizontalPadding,
          bottom: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Who are you fundraising for?",
              style: CustomFonts.bodyMedium,
            ),
            8.kH,
            CustomOutlinedTextfield(
              controller: amountController,
              label: "Full name",
            ),
            28.kH,
            Text(
              "Upload photo for your fundraiser’s beneficiary (Optional, 1 maximum)",
              style: CustomFonts.bodyMedium,
            ),
            12.kH,
            ImagePicker(),
            28.kH,
            Text(
              "Your beneficiary age?",
              style: CustomFonts.bodyMedium,
            ),
            12.kH,
            Wrap(
              direction: Axis.horizontal,
              spacing: 8,
              runSpacing: 8,
              children: [
                ...AgeGroup.values.map(
                  (age) => SelectableContainer(
                    isSelected: selectedAge == age,
                    onTap: () {
                      setState(() {
                        selectedAge = age;
                      });
                    },
                    child: Text(
                      "${age.getAgeText()} (${age.getAgeTitle()})",
                      style: CustomFonts.labelSmall.copyWith(
                        color: selectedAge == age
                            ? CustomColors.accentGreen
                            : CustomColors.textGrey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    style: CustomButtonStyle.white,
                    onPressed: widget.onPreviousPage,
                    child: Text("Back"),
                  ),
                )
              ],
            ),
            8.kH,
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: widget.onNextPage,
                    child: Text("Continue"),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ImagePicker extends StatefulWidget {
  const ImagePicker({super.key});

  @override
  State<ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: CustomColors.containerBorderGrey,
              width: 1,
            ),
          ),
          child: HeroIcon(
            HeroIcons.photo,
            style: HeroIconStyle.solid,
            size: 38,
            color: CustomColors.containerBorderGrey,
          ),
        ),
        12.kW,
        InkWell(
          onTap: () {},
          child: Ink(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: CustomColors.containerBorderGrey,
                width: 1,
              ),
            ),
            child: HeroIcon(
              HeroIcons.plus,
              style: HeroIconStyle.solid,
              size: 38,
              color: CustomColors.containerBorderGrey,
            ),
          ),
        ),
      ],
    );
  }
}
