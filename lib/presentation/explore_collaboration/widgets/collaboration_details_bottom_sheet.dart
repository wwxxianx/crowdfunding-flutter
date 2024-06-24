import 'package:cached_network_image/cached_network_image.dart';
import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/container/custom_bottom_sheet.dart';
import 'package:crowdfunding_flutter/domain/model/collaboration/collaboration.dart';
import 'package:crowdfunding_flutter/state_management/app_user_cubit.dart';
import 'package:crowdfunding_flutter/state_management/explore_collaboration/explore_collaboration_bloc.dart';
import 'package:crowdfunding_flutter/state_management/explore_collaboration/explore_collaboration_event.dart';
import 'package:crowdfunding_flutter/state_management/explore_collaboration/explore_collaboration_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';

class CollaborationDetailsBottomSheet extends StatefulWidget {
  final Collaboration collaboration;
  const CollaborationDetailsBottomSheet({
    super.key,
    required this.collaboration,
  });

  @override
  State<CollaborationDetailsBottomSheet> createState() =>
      _CollaborationDetailsBottomSheetState();
}

class _CollaborationDetailsBottomSheetState
    extends State<CollaborationDetailsBottomSheet> {
  bool isChecked = false;

  void _handleSubmit(BuildContext context) {
    if (!isChecked) {
      return;
    }
    final currentUser = context.read<AppUserCubit>().state.currentUser;
    if (currentUser == null) {
      return;
    }
    final organizationId = currentUser.organization?.id;
    if (organizationId == null) {
      return;
    }
    context.read<ExploreCollaborationBloc>().add(
          OnTakeCollaboration(
            collaborationId: widget.collaboration.id,
            organizationId: organizationId,
            onSuccess: () {
              context.pop();
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreCollaborationBloc, ExploreCollaborationState>(
      builder: (context, state) {
        return CustomDraggableSheet(
          initialChildSize: 0.95,
          footer: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.screenHorizontalPadding,
              vertical: 10,
            ),
            child: Column(
              children: [
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value ?? false;
                    });
                  },
                  title: const Text(
                    "By checking this, you accept the terms and conditions mentioned above.",
                    style: CustomFonts.bodySmall,
                  ),
                ),
                8.kH,
                SizedBox(
                  width: double.maxFinite,
                  child: CustomButton(
                    onPressed: () {
                      _handleSubmit(context);
                    },
                    child: const Text('Help this fundraiser'),
                  ),
                ),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.screenHorizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Give a help to this fundraiser',
                  style: CustomFonts.labelMedium,
                ),
                12.kH,
                AspectRatio(
                  aspectRatio: 1.45 / 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: CachedNetworkImage(
                      imageUrl: widget.collaboration.campaign.thumbnailUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                8.kH,
                Text(
                  widget.collaboration.campaign.title,
                  style: CustomFonts.titleMedium,
                ),
                16.kH,
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: CustomColors.containerLightGreen,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/hand-heart.svg'),
                          6.kW,
                          Text(
                            'Reward Sharing',
                            style: CustomFonts.labelSmall.copyWith(
                              color: CustomColors.textDarkGreen,
                            ),
                          ),
                        ],
                      ),
                      6.kH,
                      RichText(
                        text: TextSpan(
                          text: 'This fundraiser decided to give ',
                          style: CustomFonts.bodySmall.copyWith(
                            color: CustomColors.textDarkGreen,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  "${(widget.collaboration.reward * 100).toStringAsFixed(0)}%",
                              style: CustomFonts.titleSmall.copyWith(
                                color: CustomColors.textDarkGreen,
                              ),
                            ),
                            const TextSpan(
                              text:
                                  ' of each received donation for your support and contribution',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                16.kH,
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
                          HeroIcon(
                            HeroIcons.exclamationCircle,
                            style: HeroIconStyle.solid,
                            size: 20,
                            color: CustomColors.slate700,
                          ),
                          6.kW,
                          Text(
                            'Terms and Conditions',
                            style: CustomFonts.labelSmall.copyWith(
                              color: CustomColors.textDarkGreen,
                            ),
                          ),
                        ],
                      ),
                      6.kH,
                      RichText(
                        text: TextSpan(
                          text: 'Are you sure want to help ',
                          style: CustomFonts.bodySmall.copyWith(
                            color: CustomColors.slate700,
                          ),
                          children: [
                            TextSpan(
                              text: widget.collaboration.campaign.title,
                              style: CustomFonts.titleSmall.copyWith(
                                color: CustomColors.slate700,
                              ),
                            ),
                            const TextSpan(
                              text:
                                  '? Your team will share the same responsibilities of organizing and managing the fundraiser.',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
