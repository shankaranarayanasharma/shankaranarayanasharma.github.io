import 'dart:convert';
import 'package:flutter/services.dart';

class AssetManifestService {
  static Future<List<String>> getAllAssetKeys() async {
    try {
      final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
      return manifest.listAssets();
    } catch (_) {}

    try {
      final manifestContent =
          await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);
      return manifestMap.keys.toList();
    } catch (_) {}

    try {
      final manifestContent =
          await rootBundle.loadString('assets/AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);
      return manifestMap.keys.toList();
    } catch (_) {}

    return [];
  }

  static String? parsePlatformKey(String path) {
    final lower = path.toLowerCase();
    if (lower.contains('/android/') || lower.contains('_android')) {
      return "Android";
    } else if (lower.contains('/iphone/') ||
        lower.contains('/ios/') ||
        lower.contains('_iphone') ||
        lower.contains('_ios')) {
      return "iPhone";
    } else if (lower.contains('/ipad/') || lower.contains('_ipad')) {
      return "iPad";
    } else if (lower.contains('/tablet/') || lower.contains('_tablet')) {
      return "Tablet";
    } else if (lower.contains('/macos/') ||
        lower.contains('/mac/') ||
        lower.contains('_mac')) {
      return "Mac OS";
    } else if (lower.contains('/web/') || lower.contains('_web')) {
      return "Web";
    }
    return null;
  }
}
