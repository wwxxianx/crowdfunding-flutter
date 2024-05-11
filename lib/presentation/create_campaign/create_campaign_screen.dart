import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/presentation/create_campaign/widgets/beneficiary_form.dart';
import 'package:crowdfunding_flutter/presentation/create_campaign/widgets/fundraiser_description_page.dart';
import 'package:crowdfunding_flutter/presentation/create_campaign/widgets/fundraiser_details_page.dart';
import 'package:crowdfunding_flutter/presentation/create_campaign/widgets/fundraiser_media_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateCampaignScreen extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const CreateCampaignScreen());
  const CreateCampaignScreen({super.key});

  @override
  State<CreateCampaignScreen> createState() => _CreateCampaignScreenState();
}

class _CreateCampaignScreenState extends State<CreateCampaignScreen> {
  final scaffoldKey = GlobalKey();
  final totalSteps = 4;
  int currentPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _handlePageChange(int index) {
    setState(() {
      currentPage = index;
    });
  }

  void _handleNextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void _handlePreviousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  Widget _buildStepTitle() {
    late String title;
    switch (currentPage) {
      case 0:
        title = "Fundraiser Details";
        break;
      case 1:
        title = "Beneficiary Information";
        break;
      case 2:
        title = "Fundraiser Description";
        break;
      case 3:
        title = "Fundraiser Medias";
        break;
    }

    return Text(
      title,
      style: CustomFonts.titleMedium,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                  color: CustomColors.accentGreen,
                  width: 1,
                ),
                shape: BoxShape.circle,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "${currentPage + 1}",
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: CustomColors.primaryGreen,
                        ),
                      ),
                      children: [
                        TextSpan(
                          text: "/4",
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            8.kW,
            _buildStepTitle(),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height -
                  kToolbarHeight -
                  MediaQuery.of(context).viewPadding.top,
            ),
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: _handlePageChange,
              children: [
                FundraiserDetailsFormPage(
                  onNextPage: _handleNextPage,
                ),
                BeneficiaryForm(
                  onNextPage: _handleNextPage,
                  onPreviousPage: _handlePreviousPage,
                ),
                FundraiserDescriptionFormPage(
                  onNextPage: _handleNextPage,
                  onPreviousPage: _handlePreviousPage,
                ),
                FundraiserMediaUploadPage(
                  onNextPage: _handleNextPage,
                  onPreviousPage: _handlePreviousPage,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
