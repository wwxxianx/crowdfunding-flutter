import 'dart:io';

import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/container/chip.dart';
import 'package:crowdfunding_flutter/common/widgets/file_picker.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_fundraiser.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/enum/campaign_enum.dart';
import 'package:crowdfunding_flutter/state_management/fundraiser_identification/fundraiser_identification_bloc.dart';
import 'package:crowdfunding_flutter/state_management/fundraiser_identification/fundraiser_identification_event.dart';
import 'package:crowdfunding_flutter/state_management/fundraiser_identification/fundraiser_identification_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';

class FundraiserIdentificationScreen extends StatefulWidget {
  final String campaignId;
  const FundraiserIdentificationScreen({
    super.key,
    required this.campaignId,
  });

  @override
  State<FundraiserIdentificationScreen> createState() =>
      _FundraiserIdentificationScreenState();
}

class _FundraiserIdentificationScreenState
    extends State<FundraiserIdentificationScreen> {
  late TextEditingController idNumberTextController;
  final logger = Logger();

  @override
  void initState() {
    super.initState();
    idNumberTextController = TextEditingController();
  }

  @override
  void dispose() {
    idNumberTextController.dispose();
    super.dispose();
  }

  void _handleIdNumberChanged(BuildContext context, String value) {
    context
        .read<FundraiserIdentificationBloc>()
        .add(OnIdNumberChanged(value: value));
  }

  void _handleSignatureFileChanged(BuildContext context, List<File> files) {
    context
        .read<FundraiserIdentificationBloc>()
        .add(OnSignatureFileChanged(file: files.first));
  }

  void _handleSubmit(BuildContext context) {
    final fundraiserResult =
        context.read<FundraiserIdentificationBloc>().state.fundraiserResult;
    if (fundraiserResult is ApiResultSuccess<CampaignFundraiser>) {
      logger.w(fundraiserResult.data.fundraiserSignaturFileUrl);
    }
    context
        .read<FundraiserIdentificationBloc>()
        .add(OnUpdateFundraiser(campaignId: widget.campaignId));
  }

  Widget _buildStatusContent(CampaignFundraiser fundraiser) {
    final status = IdentificationStatusEnum.values
        .byName(fundraiser.user.identificationStatus);
    switch (status) {
      case IdentificationStatusEnum.PENDING:
        return CustomChip(
          style: CustomChipStyle.slate,
          child: Text(status.toString()),
        );
      case IdentificationStatusEnum.UNDER_REVIEW:
        return CustomChip(
          style: CustomChipStyle.amber,
          child: Text(status.toString()),
        );

      case IdentificationStatusEnum.VERIFIED:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomChip(
              style: CustomChipStyle.green,
              child: Text(status.toString()),
            ),
            8.kH,
            Text(
              "Your identity has been verified. You can't make any further changes.",
              style:
                  CustomFonts.labelSmall.copyWith(color: CustomColors.green700),
            ),
          ],
        );
      case IdentificationStatusEnum.REJECTED:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomChip(
              style: CustomChipStyle.red,
              child: Text(status.toString()),
            ),
            8.kH,
            Text(
              fundraiser.user.identificationRejectReason ?? '',
              style:
                  CustomFonts.labelSmall.copyWith(color: CustomColors.red700),
            ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FundraiserIdentificationBloc(
        fetchCampaignFundraiser: serviceLocator(),
        updateCampaignFundraiser: serviceLocator(),
      )..add(OnFetchCampaignFundraiser(
          campaignId: widget.campaignId,
          onSuccess: (data) {
            if (data != null) {
              idNumberTextController.text = data.user.identityNumber ?? '';
            }
          },
        )),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('assets/icons/identification.svg'),
              4.kW,
              const Text(
                'Verify your identity',
                style: CustomFonts.labelMedium,
              ),
            ],
          ),
        ),
        body: BlocConsumer<FundraiserIdentificationBloc,
            FundraiserIdentificationState>(
          listener: (context, state) {},
          builder: (context, state) {
            final fundraiserResult = state.fundraiserResult;
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.screenHorizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (fundraiserResult
                          is ApiResultSuccess<CampaignFundraiser>)
                        _buildStatusContent(fundraiserResult.data),
                      const Text(
                        'Fundraiser Identity',
                        style: CustomFonts.labelMedium,
                      ),
                      12.kH,
                      const CustomOutlinedTextfield(
                        label: 'ID Type',
                        readOnly: true,
                        initialValue: 'MyKad',
                      ),
                      8.kH,
                      CustomOutlinedTextfield(
                        label: 'ID Number',
                        // readOnly: true,
                        controller: idNumberTextController,
                        onChanged: (value) {
                          _handleIdNumberChanged(context, value);
                        },
                      ),
                      20.kH,
                      const Text(
                        'Fundraiser Identity',
                        style: CustomFonts.labelMedium,
                      ),
                      const Text(
                        'Terms and Conditions',
                        style: CustomFonts.bodySmall,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: CustomColors.containerBorderSlate),
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: CustomColors.containerSlateShadow,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                                'Please upload a photo / document of your digital signature'),
                            8.kH,
                            CustomFilePicker(
                              limit: 1,
                              onSelected: (files) {
                                _handleSignatureFileChanged(context, files);
                              },
                              canRemove: fundraiserResult
                                      is ApiResultSuccess<CampaignFundraiser> &&
                                  fundraiserResult.data
                                          .user.identificationStatus !=
                                      'VERIFIED',
                              previewFileUrls: fundraiserResult
                                          is ApiResultSuccess<
                                              CampaignFundraiser> &&
                                      fundraiserResult
                                              .data.fundraiserSignaturFileUrl !=
                                          null
                                  ? [
                                      fundraiserResult
                                          .data.fundraiserSignaturFileUrl!
                                    ]
                                  : [],
                            ),
                            Text(
                              'By checking this, you’ve read and agree to the Terms and Conditions of launching and hosting a fundraising campaign on our platform',
                              style: CustomFonts.bodyExtraSmall.copyWith(
                                color: CustomColors.textGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      20.kH,
                      SizedBox(
                        width: double.maxFinite,
                        child: CustomButton(
                          isLoading:
                              state.updateFundraiserResult is ApiResultLoading,
                          enabled: fundraiserResult
                                  is ApiResultSuccess<CampaignFundraiser> &&
                              fundraiserResult
                                      .data.user.identificationStatus !=
                                  "VERIFIED",
                          child: const Text('Submit'),
                          onPressed: () {
                            _handleSubmit(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
