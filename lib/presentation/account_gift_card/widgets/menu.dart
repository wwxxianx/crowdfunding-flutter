import 'dart:async';

import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/avatar/avatar.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/state_management/purchase_gift_card/purchase_gift_card_bloc.dart';
import 'package:crowdfunding_flutter/state_management/purchase_gift_card/purchase_gift_card_event.dart';
import 'package:crowdfunding_flutter/state_management/purchase_gift_card/purchase_gift_card_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';

class UserSearchFieldAndMenu extends StatefulWidget {
  final FocusNode focusNode;
  const UserSearchFieldAndMenu({super.key, required this.focusNode,});

  @override
  State<UserSearchFieldAndMenu> createState() => _UserSearchFieldAndMenuState();
}

class _UserSearchFieldAndMenuState extends State<UserSearchFieldAndMenu> {
  late TextEditingController _searchController;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController()..addListener(_onSearchChanged);
    final searchQuery =
        context.read<PurchaseGiftCardBloc>().state.userSearchQuery;
    if (searchQuery != null && searchQuery.isNotEmpty) {
      _searchController.text = searchQuery;
    }
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_onSearchChanged)
      ..dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_searchController.text.isEmpty) return;
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 300), () {
      context.read<PurchaseGiftCardBloc>().add(OnSearchUsers());
    });
  }

  void _handleSelectUser(UserModel user) {
    context.read<PurchaseGiftCardBloc>().add(OnSelectUser(user: user));
  }

  void _handleSearchQueryChanged(String value) {
    context
        .read<PurchaseGiftCardBloc>()
        .add(OnUserSearchQueryChanged(searchQuery: value));
  }

  void _handleRemoveSelectedUser() {
    context.read<PurchaseGiftCardBloc>().add(const OnSelectUser(user: null));
  }

  List<Widget> _buildUserSearchResultMenuItems(PurchaseGiftCardState state) {
    final usersResult = state.usersResult;
    if (usersResult is ApiResultSuccess<List<UserModel>>) {
      if (usersResult.data.isNotEmpty) {
        return usersResult.data.map((user) {
          return MenuItemButton(
            onPressed: () {
              _handleSelectUser(user);
            },
            child: Row(
              children: [
                Avatar(
                  imageUrl: user.profileImageUrl,
                  placeholder: user.fullName[0],
                  size: 36,
                ),
                8.kW,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.fullName,
                      style: CustomFonts.labelSmall,
                    ),
                    Text(
                      user.email,
                      style: CustomFonts.labelSmall.copyWith(
                        color: CustomColors.textGrey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList();
      }
      // No result
      return <Widget>[Text("No results found...")];
    }
    return [Text("searching")];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PurchaseGiftCardBloc, PurchaseGiftCardState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MenuAnchor(
              builder: (context, controller, child) {
                return CustomOutlinedTextfield(
                  errorText: state.userError,
                  focusNode: widget.focusNode,
                  controller: _searchController,
                  label: "Recipient name",
                  onTap: () {
                    controller.open();
                  },
                  onChanged: _handleSearchQueryChanged,
                  textInputAction: TextInputAction.next,
                );
              },
              menuChildren: [
                Container(
                  constraints: const BoxConstraints(
                    maxHeight: 300,
                    minHeight: 100, // Set a minimum height if needed
                  ),
                  width: MediaQuery.of(context).size.width -
                      (Dimensions.screenHorizontalPadding * 2),
                  child: SingleChildScrollView(
                    child: Column(
                      children: _buildUserSearchResultMenuItems(state),
                    ),
                  ),
                )
              ],
            ),
            8.kH,
            if (state.selectedUser != null)
              Stack(
                clipBehavior: Clip.none,
                children: [
                  IntrinsicWidth(
                    child: Container(
                      // NOTE: Use margin to make more space for remove button to
                      // be detectable by gesture
                      margin: const EdgeInsets.only(right: 14, top: 4),
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 12,
                        top: 6,
                        bottom: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // boxShadow: CustomColors.containerLightShadow,
                        border:
                            Border.all(color: CustomColors.containerBorderGrey),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Row(
                        children: [
                          Avatar(
                            imageUrl: state.selectedUser!.profileImageUrl,
                            size: 26,
                          ),
                          4.kW,
                          Text(
                            state.selectedUser!.fullName,
                            style: CustomFonts.labelExtraSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Remove button
                  Positioned(
                    right: 0,
                    top: -5,
                    child: GestureDetector(
                      onTap: _handleRemoveSelectedUser,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Color(0xFFFEFEFE)),
                          boxShadow: CustomColors.cardShadow,
                        ),
                        padding: const EdgeInsets.all(4.0),
                        child: const HeroIcon(
                          HeroIcons.xMark,
                          style: HeroIconStyle.mini,
                          color: Color(0xFFAEAEAE),
                          size: 16.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
