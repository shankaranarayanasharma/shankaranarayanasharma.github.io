import 'package:flutter/material.dart';

enum PlatformDeviceType {
  all,
  iPhone,
  android,
  tablet,
  iPad,
  macOS,
  web,
}

class CarouselHelpers {
  static int getPlatformPriority(String platform) {
    final lower = platform.toLowerCase();
    if (lower.contains("android")) return 0;
    if (lower.contains("iphone") || lower.contains("ios")) return 1;
    if (lower.contains("tablet")) return 2;
    if (lower.contains("ipad")) return 3;
    if (lower.contains("web")) return 4;
    if (lower.contains("desktop") || lower.contains("mac")) return 5;
    return 6;
  }

  static PlatformDeviceType getDeviceTypeForMedia(
      String mediaUrl, int index, String selectedPlatform) {
    final lower = selectedPlatform.toLowerCase();
    if (lower.contains("iphone") || lower.contains("ios")) return PlatformDeviceType.iPhone;
    if (lower.contains("android")) return PlatformDeviceType.android;
    if (lower.contains("ipad")) return PlatformDeviceType.iPad;
    if (lower.contains("tablet")) return PlatformDeviceType.tablet;
    if (lower.contains("mac") || lower.contains("desktop")) return PlatformDeviceType.macOS;
    if (lower.contains("web") || lower.contains("browser")) return PlatformDeviceType.web;
    return PlatformDeviceType.iPhone;
  }

  static IconData getIconForPlatform(String platform) {
    final lower = platform.toLowerCase();
    if (lower.contains("android")) return Icons.android_rounded;
    if (lower.contains("iphone") || lower.contains("ios")) return Icons.phone_iphone_rounded;
    if (lower.contains("ipad")) return Icons.tablet_mac_rounded;
    if (lower.contains("tablet")) return Icons.tablet_rounded;
    if (lower.contains("mac")) return Icons.laptop_mac_rounded;
    if (lower.contains("web")) return Icons.language_rounded;
    return Icons.view_carousel_rounded;
  }

  static Widget buildImage(String path, {BoxFit fit = BoxFit.contain}) {
    if (path.startsWith("assets/")) {
      return Image.asset(
        path,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => errorPlaceholder(),
      );
    } else {
      return Image.network(
        path,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => errorPlaceholder(),
      );
    }
  }

  static Widget errorPlaceholder() {
    return Container(
      color: const Color(0xFF1E1E24),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.broken_image_rounded, color: Colors.grey, size: 36),
            SizedBox(height: 8),
            Text(
              "Media Preview",
              style: TextStyle(color: Colors.grey, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
