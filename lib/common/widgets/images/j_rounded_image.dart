import 'package:flutter/material.dart';
import 'package:jikjjang_app/utils/constants/colors.dart';
import 'package:jikjjang_app/utils/constants/sizes.dart';

class RoundedImage extends StatelessWidget {
  const RoundedImage({
    super.key,
    this.width = 150,
    this.height = 158,
    required this.imageUrl,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor = JAppColors.backgroundLight,
    this.fit = BoxFit.contain,
    this.padding,
    this.isNetworkImage = false,
    required this.onPressed,
    this.borderRadius = JSizes.paddingMD,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
            borderRadius: applyImageRadius
                ? BorderRadius.circular(borderRadius)
                : BorderRadius.zero),
        child: ClipRRect(
            borderRadius: applyImageRadius
                ? BorderRadius.circular(borderRadius)
                : BorderRadius.zero,
            child: Image(
              image: !isNetworkImage
                  ? AssetImage(imageUrl)
                  : NetworkImage(imageUrl) as ImageProvider,
              fit: fit,
            )),
      ),
    );
  }
}
