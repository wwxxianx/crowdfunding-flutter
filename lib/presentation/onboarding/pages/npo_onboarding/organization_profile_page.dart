import 'dart:io';

import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/phone_input_formatter.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:crowdfunding_flutter/common/widgets/single_image_picker.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:crowdfunding_flutter/presentation/onboarding/pages/npo_onboarding/join_npo_success_page.dart';
import 'package:crowdfunding_flutter/state_management/onboarding/create_npo/create_npo_bloc.dart';
import 'package:crowdfunding_flutter/state_management/onboarding/create_npo/create_npo_event.dart';
import 'package:crowdfunding_flutter/state_management/onboarding/create_npo/create_npo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';

class OrganizationProfilePage extends StatelessWidget {
  final VoidCallback onNextPage;
  final VoidCallback onPreviousPage;
  const OrganizationProfilePage({
    super.key,
    required this.onNextPage,
    required this.onPreviousPage,
  });

  void _handleNameChanged(BuildContext context, String value) {
    context.read<CreateNpoBloc>().add(OnNpoNameChanged(value));
  }

  void _handleEmailChanged(BuildContext context, String value) {
    context.read<CreateNpoBloc>().add(OnEmailChanged(value));
  }

  void _handlePhoneNumberChanged(BuildContext context, String value) {
    context.read<CreateNpoBloc>().add(OnPhoneNumberChanged(value));
  }

  void _handleImageFileChanged(BuildContext context, File file) {
    context.read<CreateNpoBloc>().add(OnImageFileChanged(file));
  }

  void _handleSubmit(BuildContext context) {
    context.read<CreateNpoBloc>().add(
      OnCreateOrganization(
        onSuccess: onNextPage,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateNpoBloc, CreateNpoState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            onPreviousPage();
            return false;
          },
          child: LayoutBuilder(
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
                          Row(
                            children: [
                              SvgPicture.asset(
                                  "assets/icons/organization-filled.svg"),
                              4.kW,
                              const Text(
                                "Finish setting up your NPO",
                                style: CustomFonts.titleLarge,
                              ),
                            ],
                          ),
                          const Text(
                            "The information provided should correctly reflect your NPO.",
                            style: CustomFonts.labelSmall,
                          ),
                          30.kH,
                          //Form
                          Align(
                            alignment: Alignment.center,
                            child: SingleImagePicker(
                              size: 130,
                              onFileChanged: (file) {
                                _handleImageFileChanged(context, file);
                              },
                            ),
                          ),
                          24.kH,
                          CustomOutlinedTextfield(
                            initialValue: state.npoName,
                            label: "NPO Name",
                            onChanged: (value) {
                              _handleNameChanged(context, value);
                            },
                            errorText: state.npoNameError,
                          ),
                          20.kH,
                          CustomOutlinedTextfield(
                            initialValue: state.npoEmail,
                            label: "NPO Email",
                            onChanged: (value) {
                              _handleEmailChanged(context, value);
                            },
                            errorText: state.npoEmailError,
                            prefixIcon: const HeroIcon(
                              HeroIcons.envelope,
                              size: 18,
                            ),
                          ),
                          20.kH,
                          CustomOutlinedTextfield(
                            inputFormatters: [PhoneInputFormatter()],
                            initialValue: state.npoPhoneNumber,
                            label: "Contact Phone Number",
                            onChanged: (value) {
                              _handlePhoneNumberChanged(context, value);
                            },
                            errorText: state.npoPhoneNumberError,
                            keyboardType: TextInputType.phone,
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.only(left: 12.0, right: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                      "assets/images/malaysia-flag.png"),
                                  4.kW,
                                  const Text(
                                    "+60",
                                    style: CustomFonts.labelSmall,
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  style: CustomButtonStyle.white,
                                  onPressed: onPreviousPage,
                                  child: const Text("Back"),
                                ),
                              ),
                            ],
                          ),
                          8.kH,
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  isLoading: state.createOrganizationResult is ApiResultLoading,
                                  enabled: state.createOrganizationResult is! ApiResultLoading,
                                  onPressed: () {
                                    _handleSubmit(context);
                                  },
                                  child: const Text("Next"),
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
          ),
        );
      },
    );
  }
}
