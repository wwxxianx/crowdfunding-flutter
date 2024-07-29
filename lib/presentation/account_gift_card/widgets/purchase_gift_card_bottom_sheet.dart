import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/avatar/avatar.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/container/custom_bottom_sheet.dart';
import 'package:crowdfunding_flutter/common/widgets/input/money_input.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:crowdfunding_flutter/common/widgets/skeleton.dart';
import 'package:crowdfunding_flutter/common/widgets/text/stroke_text.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/presentation/account_gift_card/widgets/menu.dart';
import 'package:crowdfunding_flutter/state_management/purchase_gift_card/purchase_gift_card_bloc.dart';
import 'package:crowdfunding_flutter/state_management/purchase_gift_card/purchase_gift_card_event.dart';
import 'package:crowdfunding_flutter/state_management/purchase_gift_card/purchase_gift_card_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class PurchaseGiftCardBottomSheet extends StatefulWidget {
  const PurchaseGiftCardBottomSheet({super.key});

  @override
  State<PurchaseGiftCardBottomSheet> createState() =>
      _PurchaseGiftCardBottomSheetState();
}

class _PurchaseGiftCardBottomSheetState
    extends State<PurchaseGiftCardBottomSheet>
    with SingleTickerProviderStateMixin {
  final PageController pageViewController = PageController();

  void _navigateToNextPage() {
    pageViewController.nextPage(
        duration: const Duration(milliseconds: 700), curve: Curves.ease);
  }

  void _navigateToPreviousPage() {
    pageViewController.previousPage(
        duration: const Duration(milliseconds: 700), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PurchaseGiftCardBloc(
        fetchUsers: serviceLocator(),
        paymentService: serviceLocator(),
      ),
      child: CustomDraggableSheet(
        initialChildSize: 0.95,
        child: Container(
          constraints: BoxConstraints(
            maxHeight: (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).viewPadding.top) /
                100 *
                90,
          ),
          child: PageView(
            controller: pageViewController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              PurchaseGiftCardPage(navigateToNextPage: _navigateToNextPage),
              PurchaseGiftCardConfirmationPage(
                  navigateToPreviousPage: _navigateToPreviousPage),
            ],
          ),
        ),
      ),
    );
  }
}

class PurchaseGiftCardPage extends StatefulWidget {
  final VoidCallback navigateToNextPage;
  const PurchaseGiftCardPage({
    super.key,
    required this.navigateToNextPage,
  });

  @override
  State<PurchaseGiftCardPage> createState() => _PurchaseGiftCardPageState();
}

class _PurchaseGiftCardPageState extends State<PurchaseGiftCardPage> {
  late FocusNode userFocusNode;
  late FocusNode amountFocusNode;
  late FocusNode messageFocusNode;
  late TextEditingController amountTextController;
  late TextEditingController messageTextController;

  @override
  void initState() {
    super.initState();
    amountTextController = TextEditingController();
    messageTextController = TextEditingController();
    final state = context.read<PurchaseGiftCardBloc>().state;
    if (state.amountText != null && state.amountText!.isNotEmpty) {
      amountTextController.text = state.amountText!;
    }
    if (state.messageText != null && state.messageText!.isNotEmpty) {
      messageTextController.text = state.messageText!;
    }
    userFocusNode = FocusNode();
    amountFocusNode = FocusNode();
    messageFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    amountTextController.dispose();
    messageTextController.dispose();
    userFocusNode.dispose();
    amountFocusNode.dispose();
    messageFocusNode.dispose();
  }

  void _handleMessageTextChanged(String value) {
    context
        .read<PurchaseGiftCardBloc>()
        .add(OnMessageTextChanged(value: value));
  }

  void _handleAmountTextChanged(String value) {
    context.read<PurchaseGiftCardBloc>().add(OnAmountTextChanged(value: value));
  }

  void _navigateToConfirmationPage() {
    context
        .read<PurchaseGiftCardBloc>()
        .add(OnValidateGiftCardData(onSuccess: () {
      widget.navigateToNextPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PurchaseGiftCardBloc, PurchaseGiftCardState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.screenHorizontalPadding),
          child: Column(
            children: [
              const Text(
                "Purchase Gift Card",
                style: CustomFonts.labelLarge,
              ),
              20.kH,
              UserSearchFieldAndMenu(
                focusNode: userFocusNode,
              ),
              16.kH,
              MoneyTextField(
                errorText: state.amountError,
                label: "Gift amount",
                focusNode: amountFocusNode,
                controller: amountTextController,
                onChanged: _handleAmountTextChanged,
                textInputAction: TextInputAction.next,
              ),
              16.kH,
              CustomOutlinedTextfield(
                errorText: state.messageError,
                controller: messageTextController,
                onChanged: _handleMessageTextChanged,
                label: "Leave a blessing",
                maxLines: 10,
                focusNode: messageFocusNode,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (p0) {
                  _navigateToConfirmationPage();
                },
              ),
              const Spacer(),
              SizedBox(
                width: double.maxFinite,
                child: CustomButton(
                  onPressed: _navigateToConfirmationPage,
                  child: const Text("Send my gift"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class PurchaseGiftCardConfirmationPage extends StatelessWidget {
  final VoidCallback navigateToPreviousPage;
  const PurchaseGiftCardConfirmationPage({
    super.key,
    required this.navigateToPreviousPage,
  });

  void _handleCreateGiftCardAndPayment(BuildContext context) {
    context
        .read<PurchaseGiftCardBloc>()
        .add(OnCreateGiftCardAndPayment(onSuccess: () {
      context.pop();
    }));
  }

  Widget _buildReceiver(PurchaseGiftCardState state) {
    final selectedUser = state.selectedUser;
    if (selectedUser != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Avatar(
            imageUrl: selectedUser.profileImageUrl,
            placeholder: selectedUser.fullName[0],
            size: 26,
            border: Border.all(color: Colors.black),
          ),
          Text(
            selectedUser.fullName,
            style: GoogleFonts.merienda(
              textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
            ),
          )
        ],
      );
    }
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Skeleton(
          radius: 100,
          width: 26,
          height: 26,
        ),
        Skeleton(
          width: 100,
          height: Dimensions.loadingBodyHeight,
        ),
      ],
    );
  }

  Widget _buildMessageText(PurchaseGiftCardState state) {
    final message = state.messageText;
    if (message != null && message.isNotEmpty) {
      return Text(
        message,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.merienda(
          textStyle: const TextStyle(fontSize: 8),
        ),
      );
    }
    return Text(
      "You didn't leave any message for this gift",
      style: GoogleFonts.merienda(
        textStyle: const TextStyle(fontSize: 8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PurchaseGiftCardBloc, PurchaseGiftCardState>(
      builder: (context, state) {
        return Column(
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: SvgPicture.asset(
                    "assets/images/gift-card-send.svg",
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  width: MediaQuery.of(context).size.width / 4.5,
                  child: _buildMessageText(state),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 175),
                  width: MediaQuery.of(context).size.width / 2.7,
                  child: _buildReceiver(state),
                ),
              ],
            ),
            20.kH,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "A gift of ",
                  style: CustomFonts.labelLarge.copyWith(fontSize: 20),
                ),
                StrokeText(
                  text: state.amountText != null ? state.amountText! : "RM-",
                  strokeColor: Colors.black,
                  textStyle: CustomFonts.labelLarge.copyWith(
                    fontSize: 22,
                    color: CustomColors.primaryGreen,
                  ),
                ),
                Text(
                  " will be sent to:",
                  style: CustomFonts.labelLarge.copyWith(fontSize: 20),
                ),
              ],
            ),
            Text(
              state.selectedUser != null ? state.selectedUser!.fullName : "",
              style: CustomFonts.labelLarge.copyWith(fontSize: 20),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.screenHorizontalPadding),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      style: CustomButtonStyle.white,
                      onPressed: () {
                        navigateToPreviousPage();
                      },
                      child: Text(
                        "Back",
                      ),
                    ),
                  )
                ],
              ),
            ),
            8.kH,
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.screenHorizontalPadding),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      isLoading: state.createGiftCardResult is ApiResultLoading,
                      enabled: state.createGiftCardResult is! ApiResultLoading,
                      onPressed: () {
                        _handleCreateGiftCardAndPayment(context);
                      },
                      child: const Text(
                        "Yes, Send my gift!",
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
