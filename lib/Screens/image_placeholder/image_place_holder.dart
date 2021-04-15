import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
class ImagePlaceholderNetwork extends StatelessWidget {
  final String url;
  final double height;
  final double width;
  final double radius;
  final bool circular;
  final bool cover;
  final String text;

  ImagePlaceholderNetwork(
      this.url, {
        this.height = 100.0,
        this.width,
        this.circular = false,
        this.radius = 0.0,
        this.cover = true,
        this.text = '',
      });

  @override
  Widget build(BuildContext context) {
    double _radius = radius != 0.0 ? radius : (circular ? height / 2 : 0);
    return ClipRRect(
      borderRadius: BorderRadius.circular(_radius),
      child: url.isEmpty
          ? (text.isEmpty
          ? ImagePlaceholder(height, width)
          : TextPlaceHolder(
        height: height,
        width: width,
        text: text,
      ))
          : CachedNetworkImage(
        height: height,
        width: width,
        fit: this.cover ? BoxFit.cover : BoxFit.contain,
        placeholder: (context, url) => text.isEmpty
            ? ImagePlaceholder(height, width)
            : TextPlaceHolder(
          height: height,
          width: width,
          text: text,
        ),
        imageUrl: url,
      ),
    );
  }
}

class ImagePlaceholder extends StatelessWidget {
  final double height;
  final double width;

  ImagePlaceholder([this.height = 60.0, this.width = 60.0]);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'images/placeholder.png',
      height: height,
      width: width,
      fit: BoxFit.cover,
    );
  }
}

class TextPlaceHolder extends StatelessWidget {
  final double height;
  final double width;
  final String text;

  const TextPlaceHolder({
    @required this.height,
    @required this.width,
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: Colors.grey,
      child: Center(
        child: Text(
          text.substring(0, 1).toUpperCase(),
          style: TextStyle(
            fontSize: 26.0,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}