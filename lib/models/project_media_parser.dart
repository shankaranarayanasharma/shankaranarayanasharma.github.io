class ProjectMediaParser {
  static Map<String, List<String>>? parseMediaByPlatform(dynamic rawMediaByPlatform, List<String> rawMedia) {
    if (rawMediaByPlatform is Map) {
      final parsedMediaByPlatform = <String, List<String>>{};
      rawMediaByPlatform.forEach((k, v) {
        if (v is List) {
          parsedMediaByPlatform[k.toString()] =
              List<String>.from(v.map((e) => e.toString()));
        }
      });
      return parsedMediaByPlatform;
    }

    final autoGrouped = <String, List<String>>{};
    for (final path in rawMedia) {
      final lower = path.toLowerCase();
      String? platformKey;
      if (lower.contains('/android/') ||
          lower.contains('_android') ||
          lower.contains('-android')) {
        platformKey = "Android";
      } else if (lower.contains('/iphone/') ||
          lower.contains('/ios/') ||
          lower.contains('_iphone') ||
          lower.contains('_ios')) {
        platformKey = "iPhone";
      } else if (lower.contains('/ipad/') || lower.contains('_ipad')) {
        platformKey = "iPad";
      } else if (lower.contains('/tablet/') || lower.contains('_tablet')) {
        platformKey = "Tablet";
      } else if (lower.contains('/macos/') ||
          lower.contains('/mac/') ||
          lower.contains('_mac')) {
        platformKey = "Mac OS";
      } else if (lower.contains('/web/') || lower.contains('_web')) {
        platformKey = "Web";
      }

      if (platformKey != null) {
        autoGrouped.putIfAbsent(platformKey, () => []).add(path);
      }
    }
    if (autoGrouped.isNotEmpty) {
      return autoGrouped;
    }
    return null;
  }
}
