import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/container/fundraiser_identification_card.dart';
import 'package:crowdfunding_flutter/state_management/app_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

class CreateCampaignSuccessScreen extends StatelessWidget {
  final String campaignId;
  const CreateCampaignSuccessScreen({
    super.key,
    required this.campaignId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Your fundraiser will be published once it’s verified!',
          style: CustomFonts.labelMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.screenHorizontalPadding),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: CustomColors.slate100,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Symbols.add_moderator_rounded,
                        size: 20,
                        color: CustomColors.accentGreen,
                      ),
                      4.kW,
                      const Text(
                        'Campaign Verification',
                        style: CustomFonts.labelMedium,
                      ),
                    ],
                  ),
                  6.kH,
                  Text(
                    'To prevent any possible fraud case, and to protect our donors, every fundraiser have to be verified by our team first. Don’t worry, the verification process normally takes only few minutes or hours.',
                    style: CustomFonts.bodySmall
                        .copyWith(color: CustomColors.slate700),
                  ),
                ],
              ),
            ),
            Builder(
              builder: (context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'What to do next?',
                      style: CustomFonts.labelMedium,
                    ),
                    8.kH,
                    const FundraiserIdentificationCard(),
                  ],
                );
              },
            ),
            const Spacer(),
            Builder(
              builder: (context) {
                final currentUser =
                    context.watch<AppUserCubit>().state.currentUser;
                final actionText =
                    currentUser != null && currentUser.stripeConnectId != null
                        ? 'See my campaign'
                        : 'Setup my bank account';
                return Row(
                  children: [
                    Expanded(
                        child: CustomButton(
                      onPressed: () {},
                      child: Text(actionText),
                    ))
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
