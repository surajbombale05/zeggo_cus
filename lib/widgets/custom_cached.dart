import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedCard extends StatelessWidget {
  final double? height;
  final double? width;
  final BoxFit? fit;
  final String imageUrl;

  const CustomCachedCard({super.key, this.height, this.width, required this.imageUrl, this.fit});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: height,
      width: width,
      fit: fit ?? BoxFit.cover,
      placeholder: (context, url) => const Center(child:CircularProgressIndicator()),
      errorWidget: (context, url, error) => Center(
        child: Text("No Img Found 😒",),
      ),
    );
  }
}
