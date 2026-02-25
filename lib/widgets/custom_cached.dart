import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zeggo_cus/constants/app_colors.dart';

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
      cacheKey: imageUrl,
      fit: fit ?? BoxFit.cover,
      placeholder: (context, url) => Center(
        child: SizedBox(height: 10, width: 10, child: CircularProgressIndicator(color: AppColors.kGreyColor)),
      ),
      errorWidget: (context, url, error) => Center(
        child: Text("No Img Found 😒", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
      ),
    );
  }
}
