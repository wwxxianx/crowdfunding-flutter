import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String? imageUrl;
  final double size;
  const Avatar({
    super.key,
    required this.imageUrl,
    this.size = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        // child: FadeInImage.memoryNetwork(
        //   placeholder: kTransparentImage,
        //   image: "",
        // ),
        child: Image.asset("assets/images/avatar-sample.png"),
      ),
    );
  }
}
