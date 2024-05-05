import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:crowdfunding_flutter/common/widgets/input/decorated_input_border.dart';

class CustomOutlinedTextfield extends StatefulWidget {
  final FocusNode? focusNode;
  final String label;
  final String? hintText;
  final TextEditingController controller;
  final bool isObscureText;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final void Function(String)? onFieldSubmitted;

  const CustomOutlinedTextfield({
    super.key,
    this.focusNode,
    required this.label,
    this.hintText,
    required this.controller,
    this.isObscureText = false,
    this.validator,
    this.prefixIcon,
    this.textInputAction = TextInputAction.done,
    this.keyboardType = TextInputType.text,
    this.onFieldSubmitted,
  });

  @override
  State<CustomOutlinedTextfield> createState() =>
      _CustomOutlinedTextfieldState();
}

class _CustomOutlinedTextfieldState extends State<CustomOutlinedTextfield> {
  bool _isShowingText = true;

  @override
  void initState() {
    super.initState();
    if (widget.isObscureText) {
      _isShowingText = false;
      return;
    }
    _isShowingText = true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: CustomFonts.labelSmall,
        ),
        const SizedBox(height: 4.0),
        TextFormField(
          onFieldSubmitted: widget.onFieldSubmitted,
          controller: widget.controller,
          validator: widget.validator,
          obscureText: !_isShowingText,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          cursorColor: CustomColors.accentGreen,
          style: CustomFonts.labelSmall,
          decoration: InputDecoration(
            hintText: widget.hintText,
            suffixIcon: widget.isObscureText
                ? IconButton(
                    onPressed: () =>
                        setState(() => _isShowingText = !_isShowingText),
                    icon: Icon(_isShowingText
                        ? Icons.visibility
                        : Icons.visibility_off))
                : null,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: DecoratedInputBorder(
              child: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: CustomColors.accentGreen, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              shadow: BoxShadow(
                blurRadius: 4.0,
                offset: Offset(0, 0),
                color: CustomColors.accentGreen.withOpacity(0.4),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: CustomColors.inputBorder, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            prefixIcon: widget.prefixIcon,
            contentPadding: EdgeInsets.symmetric(
              horizontal: widget.prefixIcon != null ? 4.0 : 12.0,
              vertical: 4.0,
            ),
          ),
        ),
      ],
    );
  }
}
