import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:crowdfunding_flutter/common/widgets/media_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateCampaignUpdateScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
      builder: (context) => const CreateCampaignUpdateScreen());
  const CreateCampaignUpdateScreen({super.key});

  @override
  State<CreateCampaignUpdateScreen> createState() =>
      _CreateCampaignUpdateScreenState();
}

class _CreateCampaignUpdateScreenState
    extends State<CreateCampaignUpdateScreen> {
  final titleTextController = TextEditingController();
  final contentTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Update",
          style: CustomFonts.titleMedium,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: Dimensions.screenHorizontalPadding,
              right: Dimensions.screenHorizontalPadding,
              bottom: Dimensions.screenHorizontalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: CustomColors.containerBorderGrey),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset("assets/icons/magic-stick.svg"),
                      6.kW,
                      Flexible(
                        child: Text(
                            "Tips: Upload a high-quality photo or video that can share meaningful information and build trust with your donors."),
                      ),
                    ],
                  ),
                ),
                20.kH,
                Text(
                  "Upload photo for your fundraiser update and donors (3 maximum)",
                  style: CustomFonts.bodyMedium,
                ),
                12.kH,
                MediaPicker(
                  limit: 3,
                ),
                24.kH,
                Text(
                  "What do you want to share with donors?",
                  style: CustomFonts.bodyMedium,
                ),
                4.kH,
                CustomOutlinedTextfield(
                  label: "Title",
                  controller: titleTextController,
                ),
                12.kH,
                CustomOutlinedTextfield(
                  label: "Content",
                  controller: contentTextController,
                  maxLines: 10,
                ),
                28.kH,
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () {},
                        child: Text("Publish"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
