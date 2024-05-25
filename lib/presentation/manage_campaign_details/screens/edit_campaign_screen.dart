import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/presentation/manage_campaign_details/widgets/edit_beneficiary_form.dart';
import 'package:crowdfunding_flutter/presentation/manage_campaign_details/widgets/edit_fundraiser_description.dart';
import 'package:crowdfunding_flutter/presentation/manage_campaign_details/widgets/edit_fundraiser_details_form.dart';
import 'package:crowdfunding_flutter/presentation/manage_campaign_details/widgets/edit_fundraiser_medias.dart';
import 'package:crowdfunding_flutter/state_management/create_campaign/create_campaign_bloc.dart';
import 'package:crowdfunding_flutter/state_management/edit_campaign/edit_campaign_bloc.dart';
import 'package:crowdfunding_flutter/state_management/edit_campaign/edit_campaign_event.dart';
import 'package:crowdfunding_flutter/state_management/edit_campaign/edit_campaign_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditCampaignScreen extends StatelessWidget {
  static const route = '/edit-campaign/:campaignId';
  static generateRoute({required String campaignId}) =>
      '/edit-campaign/$campaignId';
  final String campaignId;
  const EditCampaignScreen({
    super.key,
    required this.campaignId,
  });

  void _handleUpdateCampaign(BuildContext context) {
    context.read<EditCampaignBloc>().add(OnUpdateCampaign(onSuccess: () {}));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditCampaignBloc(
        fetchCampaign: serviceLocator(),
        updateCampaign: serviceLocator(),
      )..add(OnFetchCampaign(campaignId: campaignId)),
      child: BlocConsumer<EditCampaignBloc, EditCampaignState>(
        listener: (context, state) {
          // Populate input with fetched data
          final campaignResult = state.campaignResult;
          if (campaignResult is ApiResultSuccess<Campaign>) {
            final bloc = context.read<EditCampaignBloc>();
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Edit Fundraiser"),
              centerTitle: true,
            ),
            bottomSheet: Container(
              decoration: const BoxDecoration(
                border: Border.symmetric(
                  horizontal:
                      BorderSide(color: CustomColors.containerBorderGrey),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.screenHorizontalPadding,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      isLoading: state is ApiResultLoading,
                      enabled: state is! ApiResultLoading,
                      onPressed: () {
                        _handleUpdateCampaign(context);
                      },
                      child: Text("Save Changes"),
                    ),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: Dimensions.screenHorizontalPadding,
                  right: Dimensions.screenHorizontalPadding,
                  bottom: 84,
                ),
                child: Column(
                  children: [
                    EditFundraiserDetailsForm(),
                    24.kH,
                    EditBeneficiaryForm(),
                    24.kH,
                    EditFundraiserDescriptionForm(),
                    24.kH,
                    EditFundraiserMediasForm(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
