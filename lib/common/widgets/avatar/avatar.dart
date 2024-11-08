import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final File? filePath;
  final String? imageUrl;
  final double size;
  final String placeholder;
  final Border border;
  const Avatar({
    super.key,
    required this.imageUrl,
    this.size = 40.0,
    this.filePath,
    this.placeholder = "a",
    this.border = const Border(
      bottom: BorderSide(color: CustomColors.containerBorderGrey),
      top: BorderSide(color: CustomColors.containerBorderGrey),
      right: BorderSide(color: CustomColors.containerBorderGrey),
      left: BorderSide(color: CustomColors.containerBorderGrey),
    ),
  });

  Widget _buildImage() {
    if (filePath != null) {
      return Image.file(
        filePath!,
        fit: BoxFit.cover,
      );
    }
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return CachedNetworkImage(
        placeholder: (context, url) {
          return Container(
            width: size,
            height: size,
            child: Text(
              placeholder.toUpperCase(),
              style: CustomFonts.titleExtraLarge.copyWith(
                color: Colors.black38,
              ),
            ),
          );
        },
        imageUrl: imageUrl!,
        fit: BoxFit.cover,
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          placeholder.toUpperCase(),
          style: CustomFonts.titleExtraLarge.copyWith(
            color: Colors.black38,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        border: border,
        color: CustomColors.slate300,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: _buildImage(),
      ),
    );
  }
}
