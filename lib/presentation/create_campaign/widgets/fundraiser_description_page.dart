import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:crowdfunding_flutter/presentation/create_campaign/widgets/tips_button.dart';
import 'package:crowdfunding_flutter/state_management/create_campaign/create_campaign_bloc.dart';
import 'package:crowdfunding_flutter/state_management/create_campaign/create_campaign_event.dart';
import 'package:crowdfunding_flutter/state_management/create_campaign/create_campaign_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FundraiserDescriptionFormPage extends StatefulWidget {
  final VoidCallback onNextPage;
  final VoidCallback onPreviousPage;
  const FundraiserDescriptionFormPage({
    super.key,
    required this.onNextPage,
    required this.onPreviousPage,
  });

  @override
  State<FundraiserDescriptionFormPage> createState() =>
      _FundraiserDescriptionFormPageState();
}

class _FundraiserDescriptionFormPageState
    extends State<FundraiserDescriptionFormPage> {
  final titleTextController = TextEditingController();
  final descriptionTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final titleText = context.read<CreateCampaignBloc>().state.titleText;
    if (titleText != null) {
      titleTextController.text = titleText;
    }
    final descriptionText =
        context.read<CreateCampaignBloc>().state.descriptionText;
    if (descriptionText != null) {
      descriptionTextController.text = descriptionText;
    }
  }

  void _navigateToNextPage() {
    context.read<CreateCampaignBloc>().add(ValidateStepThree(
      onSuccess: () {
        widget.onNextPage();
      },
    ));
  }

  void _handleTitleChanged(title) {
    context.read<CreateCampaignBloc>().add(OnTitleChanged(title: title));
  }

  void _handleDescriptionChanged(description) {
    context
        .read<CreateCampaignBloc>()
        .add(OnDescriptionChanged(description: description));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateCampaignBloc, CreateCampaignState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            widget.onPreviousPage();
            return false;
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: Dimensions.screenHorizontalPadding,
                        right: Dimensions.screenHorizontalPadding,
                        bottom: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Give your fundraiser a title",
                            style: CustomFonts.bodyMedium,
                          ),
                          8.kH,
                          CustomOutlinedTextfield(
                            errorText: state.titleError,
                            label: "Title",
                            controller: titleTextController,
                            onChanged: _handleTitleChanged,
                          ),
                          8.kH,
                          TipsButton(onPressed: () {}),
                          28.kH,
                          const Text(
                            "Let others know more about your fundraiser",
                            style: CustomFonts.bodyMedium,
                          ),
                          8.kH,
                          CustomOutlinedTextfield(
                            errorText: state.descriptionError,
                            onChanged: _handleDescriptionChanged,
                            controller: descriptionTextController,
                            label: "Content",
                            maxLines: 10,
                            hintText: "Hello, I’m Ellisa and would like to...",
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  style: CustomButtonStyle.white,
                                  onPressed: widget.onPreviousPage,
                                  child: const Text("Back"),
                                ),
                              )
                            ],
                          ),
                          8.kH,
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  onPressed: _navigateToNextPage,
                                  child: const Text("Continue"),
                                ),
                              )
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
      },
    );
  }
}
