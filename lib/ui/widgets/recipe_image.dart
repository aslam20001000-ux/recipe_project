import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Network recipe image with a loading and an error placeholder.
class RecipeImage extends StatelessWidget {
  const RecipeImage(
    this.url, {
    super.key,
    this.fit = BoxFit.cover,
    this.borderRadius = BorderRadius.zero,
  });

  final String url;
  final BoxFit fit;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: borderRadius,
    child: Image.network(
      url,
      fit: fit,
      width: double.infinity,
      height: double.infinity,
      loadingBuilder: (context, child, progress) =>
          progress == null ? child : const _Placeholder(loading: true),
      errorBuilder: (context, error, stack) => const _Placeholder(),
    ),
  );
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({this.loading = false});

  final bool loading;

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: AppColors.surfaceHigh,
    child: Center(
      child: loading
          ? const SizedBox.square(
              dimension: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.restaurant, color: AppColors.textMuted),
    ),
  );
}
