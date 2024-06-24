import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/string.dart';
import 'package:crowdfunding_flutter/common/widgets/campaign/campaign_card.dart';
import 'package:crowdfunding_flutter/common/widgets/tag/custom_tag.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/domain/model/collaboration/collaboration.dart';
import 'package:crowdfunding_flutter/presentation/explore_collaboration/widgets/collaboration_details_bottom_sheet.dart';
import 'package:crowdfunding_flutter/state_management/explore_collaboration/explore_collaboration_bloc.dart';
import 'package:crowdfunding_flutter/state_management/explore_collaboration/explore_collaboration_event.dart';
import 'package:crowdfunding_flutter/state_management/explore_collaboration/explore_collaboration_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ExploreCollaborationScreen extends StatelessWidget {
  const ExploreCollaborationScreen({super.key});

  Widget _buildContent(BuildContext context) {
    final collaborationsResult =
        context.read<ExploreCollaborationBloc>().state.collaborationsResult;
    if (collaborationsResult is ApiResultSuccess<List<Collaboration>>) {
      return GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 0.58,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        scrollDirection: Axis.vertical,
        children: collaborationsResult.data.map((collaboration) {
          return CampaignCard(
            isSmall: true,
            footerAction: InkWell(
              onTap: () {
                showModalBottomSheet(
                  isDismissible: true,
                  isScrollControlled: true,
                  elevation: 0,
                  context: context,
                  builder: (modalContext) {
                    return BlocProvider.value(
                      value: BlocProvider.of<ExploreCollaborationBloc>(context),
                      child: CollaborationDetailsBottomSheet(collaboration: collaboration,),
                    );
                  },
                );
              },
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: CustomColors.primaryGreen,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Help this',
                  style: CustomFonts.labelSmall,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            headerLeadingTag: CustomTag(
              label: collaboration.createdAt.toTimeAgo(),
            ),
            headerTrailingTag: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset('assets/icons/prize-shape.svg'),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    '1%',
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }).toList(),
      );
    }
    // Loading
    return Text('Loading...');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ExploreCollaborationBloc(fetchPendingCollaborations: serviceLocator())
            ..add(OnFetchPendingCollaborations()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Help the community",
            style: CustomFonts.titleMedium,
          ),
        ),
        body: BlocBuilder<ExploreCollaborationBloc, ExploreCollaborationState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'These fundraisers are asking for help',
                      style: CustomFonts.labelMedium,
                    ),
                    12.kH,
                    _buildContent(context),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
