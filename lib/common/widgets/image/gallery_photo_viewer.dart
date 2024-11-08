import 'package:crowdfunding_flutter/domain/model/image/image_model.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper({
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex = 0,
    required this.galleryItems,
    this.scrollDirection = Axis.horizontal,
  }) : pageController = PageController(initialPage: initialIndex);

  final LoadingBuilder? loadingBuilder;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List<ImageModel> galleryItems;
  final Axis scrollDirection;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  late int currentIndex = widget.initialIndex;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton.filledTonal(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.white.withOpacity(0.87),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const HeroIcon(
            HeroIcons.chevronLeft,
            color: Colors.black,
            size: 18.0,
          ),
        ),
      ),
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: _buildItem,
              itemCount: widget.galleryItems.length,
              loadingBuilder: widget.loadingBuilder,
              backgroundDecoration: widget.backgroundDecoration,
              pageController: widget.pageController,
              onPageChanged: onPageChanged,
              scrollDirection: widget.scrollDirection,
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Image ${currentIndex + 1}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  decoration: null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final ImageModel item = widget.galleryItems[index];
    // return item.isSvg
    //     ? PhotoViewGalleryPageOptions.customChild(
    //         child: Container(
    //           width: 300,
    //           height: 300,
    //           child: SvgPicture.asset(
    //             item.resource,
    //             height: 200.0,
    //           ),
    //         ),
    //         childSize: const Size(300, 300),
    //         initialScale: PhotoViewComputedScale.contained,
    //         minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
    //         maxScale: PhotoViewComputedScale.covered * 4.1,
    //         heroAttributes: PhotoViewHeroAttributes(tag: item.id),
    //       )
    //     : PhotoViewGalleryPageOptions(
    //         imageProvider: AssetImage(item.resource),
    //         initialScale: PhotoViewComputedScale.contained,
    //         minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
    //         maxScale: PhotoViewComputedScale.covered * 4.1,
    //         heroAttributes: PhotoViewHeroAttributes(tag: item.id),
    //       );
    return PhotoViewGalleryPageOptions(
      imageProvider: NetworkImage(item.imageUrl),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 4.1,
      heroAttributes: PhotoViewHeroAttributes(tag: item.id),
    );
  }
}
