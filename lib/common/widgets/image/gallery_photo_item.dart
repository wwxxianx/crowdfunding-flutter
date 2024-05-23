import 'package:cached_network_image/cached_network_image.dart';
import 'package:crowdfunding_flutter/domain/model/image/image_model.dart';
import 'package:flutter/widgets.dart';
class GalleryPhotoItem extends StatelessWidget {
  final ImageModel imageItem;
  final GestureTapCallback onTap;
  const GalleryPhotoItem({
    Key? key,
    required this.imageItem,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        onTap: onTap,
        child: Hero(
          tag: imageItem.id,
          child: CachedNetworkImage(imageUrl: imageItem.imageUrl, height: 80.0),
        ),
      ),
    );
  }
}
