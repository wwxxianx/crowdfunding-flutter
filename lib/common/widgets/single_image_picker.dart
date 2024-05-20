import 'dart:io';

import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/avatar/avatar.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:image_picker/image_picker.dart';

class SingleImagePicker extends StatefulWidget {
  final double size;
  final void Function(File)? onFileChanged;
  final File? previewFile;
  const SingleImagePicker({
    super.key,
    this.size = 100,
    this.onFileChanged,
    this.previewFile,
  });

  @override
  State<SingleImagePicker> createState() => _SingleImagePickerState();
}

class _SingleImagePickerState extends State<SingleImagePicker> {
  final picker = ImagePicker();
  File? selectedImage;

  @override
  void initState() {
    super.initState();
    if (widget.previewFile != null) {
      selectedImage = widget.previewFile!;
    }
  }

  void _handlePickImage() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final imageFile = File(image.path);
      setState(() {
        selectedImage = imageFile;
        if (widget.onFileChanged != null) {
          widget.onFileChanged!(imageFile);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Avatar(
          imageUrl: null,
          size: widget.size,
          filePath: selectedImage,
          placeholder: "w",
        ),
        Positioned(
          bottom: -10,
          child: IntrinsicWidth(
            child: CustomButton(
              onPressed: _handlePickImage,
              borderRadius: BorderRadius.circular(100.0),
              height: 30,
              padding: const EdgeInsets.only(
                left: 6,
                right: 8,
                top: 4,
                bottom: 4,
              ),
              style: CustomButtonStyle.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeroIcon(
                    HeroIcons.pencil,
                    size: 16,
                    style: HeroIconStyle.solid,
                  ),
                  4.kW,
                  const Text(
                    "Edit",
                    style: CustomFonts.labelExtraSmall,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
