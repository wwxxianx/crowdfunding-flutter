import 'dart:io';

import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/show_snackbar.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/media_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:logger/logger.dart';

class CustomFilePicker extends StatefulWidget {
  final int limit;
  final bool canRemove;
  final List<String> previewFileUrls;
  final void Function(List<File> files)? onSelected;
  const CustomFilePicker({
    super.key,
    this.limit = 1,
    this.onSelected,
    this.canRemove = true,
    this.previewFileUrls = const [],
  });

  @override
  State<CustomFilePicker> createState() => _CustomFilePickerState();
}

class _CustomFilePickerState extends State<CustomFilePicker> {
  List<PlatformFile> selectedFiles = [];
  List<String> previewFileUrls = [];
  final logger = Logger();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(CustomFilePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (selectedFiles.isNotEmpty) return;
    if (oldWidget.previewFileUrls != widget.previewFileUrls) {
      setState(() {
        previewFileUrls = widget.previewFileUrls;
      });
    }
  }

  void _handleSelectFile() async {
    final hasExceedLimit =
        selectedFiles.length + previewFileUrls.length >= widget.limit;
    if (hasExceedLimit) {
      context.showSnackBar(
          "You can only select ${widget.limit} file${widget.limit > 1 ? 's' : ''}");
      return;
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: widget.limit > 1,
    );
    if (result == null) {
      // User canceled the picker
      return;
    }
    List<PlatformFile> pickedFiles = result.files;
    if (widget.limit == 1) {
      setState(() {
        selectedFiles = [pickedFiles.first];
      });
      File file = File(pickedFiles.single.path!);
      if (widget.onSelected != null) {
        widget.onSelected!([file]);
      }
      return;
    }
    if (pickedFiles.length > widget.limit) {
      // Take only the specified numbers of files
      pickedFiles = pickedFiles.sublist(pickedFiles.length - widget.limit);
    }
    setState(() {
      selectedFiles = pickedFiles;
    });
    if (widget.onSelected != null) {
      widget.onSelected!(pickedFiles.map((e) => File(e.path!)).toList());
    }
  }

  List<Widget> _buildPreview() {
    if (previewFileUrls.isNotEmpty) {
      return previewFileUrls.map((url) {
        return ImagePreviewContainer(
          canRemove: widget.canRemove,
          onRemove: () {
            // if (widget.onRemovePreviewImageModel != null) {
            //   widget.onRemovePreviewImageModel!(image);
            // }
            setState(() {
              previewFileUrls.remove(url);
            });
          },
          imageUrl: url,
        );
      }).toList();
    }
    return [const SizedBox()];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        runAlignment: WrapAlignment.start,
        runSpacing: 8,
        spacing: 12,
        children: [
          if (widget.previewFileUrls.isNotEmpty) ..._buildPreview(),
          ...selectedFiles.map((file) {
            return FileItem(
              canRemove: widget.canRemove,
              file: file,
              onRemove: () {
                setState(() {
                  selectedFiles.remove(file);
                });
              },
            );
          }).toList(),
          CustomButton(
            style: CustomButtonStyle.grey,
            height: 32,
            onPressed: _handleSelectFile,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const HeroIcon(
                  HeroIcons.plus,
                  style: HeroIconStyle.mini,
                  size: 20,
                  color: CustomColors.textBlack,
                ),
                4.kW,
                const Text(
                  'Pick File',
                  style: CustomFonts.labelSmall,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FileItem extends StatelessWidget {
  final PlatformFile file;
  final bool canRemove;
  final VoidCallback? onRemove;
  const FileItem({
    super.key,
    required this.file,
    this.canRemove = true,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topRight,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: CustomColors.containerBorderSlate),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const HeroIcon(
                HeroIcons.documentText,
                size: 18,
                color: CustomColors.textGrey,
              ),
              4.kW,
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 100),
                child: Text(
                  '${file.name}',
                  style: CustomFonts.labelSmall.copyWith(
                    color: CustomColors.textGrey,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
        if (canRemove)
          Positioned(
            right: -5,
            top: -5,
            child: GestureDetector(
              onTap: onRemove,
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
    );
  }
}
