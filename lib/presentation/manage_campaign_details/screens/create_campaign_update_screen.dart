import 'dart:io';

import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/container/animated_bg_container.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:crowdfunding_flutter/common/widgets/media_picker.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_update_recommendation.dart';
import 'package:crowdfunding_flutter/presentation/manage_campaign_details/widgets/ai_campaign_update_bottom_sheet.dart';
import 'package:crowdfunding_flutter/state_management/create_campaign_update/create_campaign_update_bloc.dart';
import 'package:crowdfunding_flutter/state_management/create_campaign_update/create_campaign_update_event.dart';
import 'package:crowdfunding_flutter/state_management/create_campaign_update/create_campaign_update_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class CreateCampaignUpdateScreen extends StatefulWidget {
  static const String route = '/create-campaign-update/:campaignId';
  static generateRoute({required String campaignId}) =>
      "/create-campaign-update/$campaignId";
  // static route() => MaterialPageRoute(
  //     builder: (context) => const CreateCampaignUpdateScreen());
  final String campaignId;
  const CreateCampaignUpdateScreen({
    super.key,
    required this.campaignId,
  });

  @override
  State<CreateCampaignUpdateScreen> createState() =>
      _CreateCampaignUpdateScreenState();
}

class _CreateCampaignUpdateScreenState
    extends State<CreateCampaignUpdateScreen> {
  final titleTextController = TextEditingController();
  final contentTextController = TextEditingController();
  List<File> selectedImageFiles = [];

  void _showAIBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      elevation: 0,
      context: context,
      builder: (modalContext) {
        return BlocProvider.value(
          value: BlocProvider.of<CreateCampaignUpdateBloc>(context),
          child: AICampaignUpdateBottomSheet(
            campaignId: widget.campaignId,
            onPopulateResult: (CampaignUpdateRecommendation result) {
              titleTextController.text = result.title;
              contentTextController.text = result.description;
            },
          ),
        );
      },
    );
  }

  void _handleSelectFile(List<File> files) {
    setState(() {
      selectedImageFiles = files;
    });
  }

  void _handleSubmit(BuildContext context) {
    // print("Submit update");

    context.read<CreateCampaignUpdateBloc>().add(
          OnCreateCampaignUpdate(
            title: titleTextController.text,
            description: contentTextController.text,
            campaignId: widget.campaignId,
            imageFiles: selectedImageFiles,
            onSuccess: () {
              toastification.show(
                type: ToastificationType.success,
                autoCloseDuration: const Duration(seconds: 7),
                showProgressBar: true,
                applyBlurEffect: true,
                boxShadow: lowModeShadow,
                title: Text("A NEW update created!"),
                description:
                    Text("All of the donors will receive your update soon!"),
              );
              context.pop();
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateCampaignUpdateBloc(
        createCampaignUpdate: serviceLocator(),
        createCampaignUpdateRecommendation: serviceLocator(),
      ),
      child: BlocBuilder<CreateCampaignUpdateBloc, CreateCampaignUpdateState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
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
                          border: Border.all(
                              color: CustomColors.containerBorderGrey),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset("assets/icons/magic-stick.svg"),
                            6.kW,
                            const Flexible(
                              child: Text(
                                  "Tips: Upload a high-quality photo or video that can share meaningful information and build trust with your donors."),
                            ),
                          ],
                        ),
                      ),
                      20.kH,
                      const Text(
                        "Upload photo for your fundraiser update and donors (3 maximum)",
                        style: CustomFonts.bodyMedium,
                      ),
                      12.kH,
                      MediaPicker(
                        limit: 3,
                        onSelected: _handleSelectFile,
                      ),
                      24.kH,
                      const Text(
                        "What do you want to share with donors?",
                        style: CustomFonts.bodyMedium,
                      ),
                      4.kH,
                      CustomOutlinedTextfield(
                        errorText: state.titleError,
                        label: "Title",
                        controller: titleTextController,
                      ),
                      12.kH,
                      CustomOutlinedTextfield(
                        errorText: state.descriptionError,
                        label: "Content",
                        controller: contentTextController,
                        maxLines: 10,
                      ),
                      6.kH,
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            _showAIBottomSheet(context);
                          },
                          child: AnimatedBGContainer(
                            startColor: const Color(0xFFF1FAEA),
                            endColor: const Color(0xFFB7FF87),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: CustomColors.accentGreen),
                            boxShadow: CustomColors.containerSlateShadow,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset("assets/icons/sparkles.svg"),
                                6.kW,
                                Text(
                                  "Generate for me",
                                  style: CustomFonts.labelSmall.copyWith(
                                    color: CustomColors.textDarkGreen,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      28.kH,
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              isLoading:
                                  state.createUpdateResult is ApiResultLoading,
                              // enabled:
                              //     state.createUpdateResult is! ApiResultLoading,
                              onPressed: () {
                                _handleSubmit(context);
                              },
                              child: const Text("Publish"),
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
        },
      ),
    );
  }
}
