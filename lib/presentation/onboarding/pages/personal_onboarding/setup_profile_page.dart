import 'dart:io';

import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:crowdfunding_flutter/common/widgets/single_image_picker.dart';
import 'package:crowdfunding_flutter/state_management/onboarding/personal_onboarding_bloc.dart';
import 'package:crowdfunding_flutter/state_management/onboarding/personal_onboarding_event.dart';
import 'package:crowdfunding_flutter/state_management/onboarding/personal_onboarding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingPersonalProfilePage extends StatefulWidget {
  final VoidCallback onNextPage;
  const OnboardingPersonalProfilePage({
    super.key,
    required this.onNextPage,
  });

  @override
  State<OnboardingPersonalProfilePage> createState() =>
      _OnboardingPersonalProfilePageState();
}

class _OnboardingPersonalProfilePageState
    extends State<OnboardingPersonalProfilePage> {
  final TextEditingController fullNameTextController = TextEditingController();

  void _handleSave() {
    widget.onNextPage();
  }

  @override
  void initState() {
    super.initState();
    final fullNameText = context.read<PersonalOnboardingBloc>().state.fullName;
    if (fullNameText.isNotEmpty) {
      fullNameTextController.text = fullNameText;
    }
  }

  void _handleFullNameChanged(String value) {
    context
        .read<PersonalOnboardingBloc>()
        .add(OnFullNameChanged(fullName: value));
  }

  void _handleImageFileChanged(File file) {
    context
        .read<PersonalOnboardingBloc>()
        .add(OnProfileImageFileChanged(file: file));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalOnboardingBloc, PersonalOnboardingState>(
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.screenHorizontalPadding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            // SvgPicture.asset("assets/icons/organization-filled.svg"),
                            // 4.kW,
                            Text(
                              "Set up your account profile",
                              style: CustomFonts.titleLarge,
                            ),
                          ],
                        ),
                        const Text(
                          "Other people on __ can see your name and profile image. Don’t worry, you can change your account profile at any time.",
                          style: CustomFonts.labelSmall,
                        ),
                        30.kH,
                        //Form
                        Align(
                          alignment: Alignment.center,
                          child: SingleImagePicker(
                            previewFile: state.profileImageFile,
                            size: 130,
                            onFileChanged: _handleImageFileChanged,
                          ),
                        ),
                        24.kH,
                        CustomOutlinedTextfield(
                          controller: fullNameTextController,
                          label: "Full name",
                          onChanged: _handleFullNameChanged,
                        ),

                        const Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                style: CustomButtonStyle.white,
                                onPressed: widget.onNextPage,
                                child: const Text("Skip"),
                              ),
                            ),
                          ],
                        ),
                        8.kH,
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                onPressed: _handleSave,
                                child: const Text("Save"),
                                // isLoading: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
