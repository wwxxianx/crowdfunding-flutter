import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';

class AccountLegalityScreen extends StatelessWidget {
  const AccountLegalityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset("assets/icons/scale.svg"),
            6.kW,
            const Text(
              "Legality",
              style: CustomFonts.titleMedium,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.screenHorizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomListTile(
                    title: const Text("My Scam Reports", style: CustomFonts.labelMedium,),
                    trailing: const HeroIcon(HeroIcons.chevronRight),
                    onTap: () {
                      context.push("/account/legality/scam-report");
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
