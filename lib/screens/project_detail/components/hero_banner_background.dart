import 'package:flutter/material.dart';

class HeroBannerBackground extends StatelessWidget {
  final String imagePath;

  const HeroBannerBackground({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  Widget _bg() {
    final isAsset = imagePath.startsWith('assets/');
    return isAsset
        ? Image.asset(
            imagePath,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => _fallback(),
          )
        : Image.network(
            imagePath,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => _fallback(),
          );
  }

  Widget _fallback() => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D1117), Color(0xFF1C2333)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _bg(),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.30),
                Colors.black.withValues(alpha: 0.50),
                Colors.black.withValues(alpha: 0.80),
                Colors.black.withValues(alpha: 0.97),
              ],
              stops: const [0.0, 0.25, 0.65, 1.0],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.black.withValues(alpha: 0.55),
                Colors.transparent,
              ],
              stops: const [0.0, 0.65],
            ),
          ),
        ),
      ],
    );
  }

  static IconData getPlatformIcon(String type) {
    final lower = type.toLowerCase();
    if (lower.contains('ipad') || lower.contains('tablet')) {
      return Icons.tablet_mac_rounded;
    }
    if (lower.contains('mobile') ||
        lower.contains('iphone') ||
        lower.contains('android') ||
        lower.contains('phone')) {
      return Icons.phone_iphone_rounded;
    }
    if (lower.contains('web') ||
        lower.contains('website') ||
        lower.contains('desktop')) {
      return Icons.devices_rounded;
    }
    return Icons.devices_rounded;
  }
}
