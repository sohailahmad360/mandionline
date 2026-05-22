import 'package:flutter/material.dart';

import '../color/app_colors.dart';

/// [Image.network] with loading and 404-safe fallback (avoids red screen / exceptions).
class SafeNetworkImage extends StatelessWidget {
  const SafeNetworkImage({
    super.key,
    required this.url,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
  });

  final String url;
  final double width;
  final double height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (_, __, ___) => _placeholder(),
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return SizedBox(
          width: width,
          height: height,
          child: const Center(
            child: SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        );
      },
    );
  }

  Widget _placeholder() {
    return Container(
      width: width,
      height: height,
      color: AppColors.surfaceMuted,
      alignment: Alignment.center,
      child: Icon(
        Icons.image_not_supported_outlined,
        color: AppColors.textSecondary.withValues(alpha: 0.65),
        size: (width * 0.35).clamp(20.0, 40.0),
      ),
    );
  }
}
