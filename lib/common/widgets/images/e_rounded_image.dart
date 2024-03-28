import 'package:flutter/material.dart';
import '../../../utils/constants/sizes.dart';


class ERoundImage extends StatelessWidget {
  const ERoundImage({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    this.applyImageRadius = false,
    this.border,
    this.backgroundColor,
    this.fit = BoxFit.contain,
    this.padding,
    this.onPressed,
    this.isNetworkImage = true,
    this.borderRadius = ESizes.md,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;
  final bool isNetworkImage;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(border: border, color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius)
        ),
        child: ClipRRect(
            borderRadius: applyImageRadius ? BorderRadius.zero : BorderRadius.circular(borderRadius) ,
            child: Image(image: isNetworkImage ? AssetImage(imageUrl) : NetworkImage(imageUrl) as ImageProvider, fit: fit,)),
      ),
    );
  }
}
