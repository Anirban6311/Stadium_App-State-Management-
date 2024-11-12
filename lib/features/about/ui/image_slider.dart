import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatelessWidget {
  final List<String> imageUrls;

  const ImageSlider({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: imageUrls.length,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: 80,
            width: 10,
            child: CachedNetworkImage(
              imageUrl: imageUrls[index],
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child:
                    CircularProgressIndicator(), // Display circular loader while image is loading
              ),
              errorWidget: (context, url, error) => const Icon(
                  Icons.error), // Display error icon if image fails to load
            ),
          ),
        );
      },
    );
  }
}
