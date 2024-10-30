import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageCustom extends StatefulWidget {
  final String? urlImage;

  ///Image assets local khi load url bị lỗi
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Duration? fadeOutDuration;
  final Curve fadeOutCurve;
  final Duration fadeInDuration;
  final Curve fadeInCurve;
  const ImageCustom({
    Key? key,
    required this.urlImage,
    this.height,
    this.width,
    this.fit,
    this.fadeOutDuration = const Duration(milliseconds: 1000),
    this.fadeOutCurve = Curves.easeOut,
    this.fadeInDuration = const Duration(milliseconds: 500),
    this.fadeInCurve = Curves.easeIn,
  }) : super(key: key);

  @override
  State<ImageCustom> createState() => _ImageCustomState();
}

class _ImageCustomState extends State<ImageCustom> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: widget.height,
      width: widget.height,
      fit: widget.fit,
      imageUrl: widget.urlImage ?? '',
      fadeOutDuration: widget.fadeOutDuration,
      fadeOutCurve: widget.fadeOutCurve,
      fadeInDuration: widget.fadeInDuration,
      fadeInCurve: widget.fadeInCurve,
      placeholder: (context, url) => Stack(
        children: const [
          Positioned(
            child: Center(
              child: SizedBox(
                width: 10,
                height: 10,
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                ),
              ),
            ),
          ),
        ],
      ),
      // errorWidget: (context, url, error) => placeholder,
    );
  }
}
