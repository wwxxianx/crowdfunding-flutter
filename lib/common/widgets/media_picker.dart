import 'dart:io';
import 'dart:typed_data';

import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class MediaPicker extends StatefulWidget {
  final bool isVideo;
  // Determine whether is multiple, and use to discard extra image
  final int limit;

  const MediaPicker({
    super.key,
    this.isVideo = false,
    this.limit = 1,
  });

  @override
  State<MediaPicker> createState() => _MediaPickerState();
}

class _MediaPickerState extends State<MediaPicker> {
  final picker = ImagePicker();
  List<File> selectedImages = [];
  Uint8List? videoThumbnail;

  void _handlePickButtonPressed() async {
    if (!widget.isVideo) {
      if (widget.limit == 1) {
        XFile? image = await picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          setState(() {
            selectedImages.add(File(image.path));
          });
        }
      } else {
        // Pick multiple image
        List<XFile> images = await picker.pickMultiImage();
        if (images.isNotEmpty) {
          if (images.length > widget.limit) {
            // Get the last N elements
            images = images.sublist(images.length - widget.limit);
          }
          setState(() {
            selectedImages = images.map((e) => File(e.path)).toList();
          });
        }
      }
    } else {
      // Pick video
      XFile? video = await picker.pickVideo(source: ImageSource.gallery);
      if (video != null) {
        final thumbnail = await VideoThumbnail.thumbnailData(
          video: video.path,
          imageFormat: ImageFormat.JPEG,
          maxWidth:
              128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
          quality: 25,
        );
        setState(
          () {
            selectedImages.add(File(video.path));
            videoThumbnail = thumbnail;
          },
        );
      }
    }
  }

  List<Widget> _buildContent() {
    if (selectedImages.isNotEmpty) {
      if (widget.isVideo) {
        return [
          Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: CustomColors.containerBorderGrey,
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.memory(
                videoThumbnail!,
              ),
            ),
          ),
        ];
      }
      if (widget.limit == 1) {
        return [
          Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: CustomColors.containerBorderGrey,
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.file(
                selectedImages[0],
                fit: BoxFit.cover,
              ),
            ),
          ),
        ];
      } else {
        // multiple images
        return selectedImages
            .map((image) => Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: CustomColors.containerBorderGrey,
                      width: 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.file(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ))
            .toList();
      }
    } else {
      return [
        Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: CustomColors.containerBorderGrey,
              width: 1,
            ),
          ),
          child: HeroIcon(
            widget.isVideo ? HeroIcons.videoCamera : HeroIcons.photo,
            style: HeroIconStyle.solid,
            size: 38,
            color: CustomColors.containerBorderGrey,
          ),
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      direction: Axis.horizontal,
      children: [
        ..._buildContent(),
        InkWell(
          onTap: _handlePickButtonPressed,
          child: Ink(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: CustomColors.containerBorderGrey,
                width: 1,
              ),
            ),
            child: const HeroIcon(
              HeroIcons.plus,
              style: HeroIconStyle.solid,
              size: 38,
              color: CustomColors.containerBorderGrey,
            ),
          ),
        ),
      ],
    );
  }
}
