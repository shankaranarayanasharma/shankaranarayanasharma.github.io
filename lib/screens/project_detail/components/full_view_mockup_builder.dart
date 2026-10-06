import 'package:flutter/material.dart';
import 'package:flutter_profile/constants.dart';

import '../frames/android_mockup_frame.dart';
import '../frames/ipad_mockup_frame.dart';
import '../frames/iphone_mockup_frame.dart';
import '../frames/macos_mockup_frame.dart';
import '../frames/tablet_mockup_frame.dart';
import '../frames/web_mockup_frame.dart';
import '../project_media_carousel.dart';

class FullViewMockupBuilder {
  static Widget buildMockup({
    required String path,
    required int index,
    required PlatformDeviceType Function(String path, int index) getDeviceType,
    required Widget Function(String path, {BoxFit fit}) buildImage,
    required bool mediaHasBezel,
  }) {
    final deviceType = getDeviceType(path, index);
    final lower = path.toLowerCase();
    final isVideo = lower.endsWith('.mp4') ||
        lower.endsWith('.mov') ||
        lower.endsWith('.webm') ||
        lower.endsWith('.m4v') ||
        lower.endsWith('.avi') ||
        lower.contains('youtube.com') ||
        lower.contains('vimeo.com') ||
        lower.contains('youtu.be');

    final imageWidget = Stack(
      fit: StackFit.expand,
      children: [
        buildImage(path, fit: BoxFit.fill),
        if (isVideo)
          Center(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.65),
                shape: BoxShape.circle,
                border: Border.all(
                  color: primaryColor.withValues(alpha: 0.8),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: 0.3),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
      ],
    );

    if (mediaHasBezel) {
      return SizedBox(
        width: 235,
        height: 470,
        child: imageWidget,
      );
    }

    switch (deviceType) {
      case PlatformDeviceType.android:
        return AndroidMockupFrame(
          isHovered: false,
          isVideo: isVideo,
          margin: EdgeInsets.zero,
          child: imageWidget,
        );
      case PlatformDeviceType.tablet:
        return TabletMockupFrame(
          isHovered: false,
          isVideo: isVideo,
          margin: EdgeInsets.zero,
          child: imageWidget,
        );
      case PlatformDeviceType.iPad:
        return IPadMockupFrame(
          isHovered: false,
          isVideo: isVideo,
          margin: EdgeInsets.zero,
          child: imageWidget,
        );
      case PlatformDeviceType.macOS:
        return MacOSMockupFrame(
          isHovered: false,
          isVideo: isVideo,
          margin: EdgeInsets.zero,
          child: imageWidget,
        );
      case PlatformDeviceType.web:
        return WebMockupFrame(
          isHovered: false,
          isVideo: isVideo,
          margin: EdgeInsets.zero,
          child: imageWidget,
        );
      case PlatformDeviceType.all:
      case PlatformDeviceType.iPhone:
      default:
        return IPhoneMockupFrame(
          isHovered: false,
          isVideo: isVideo,
          margin: EdgeInsets.zero,
          child: imageWidget,
        );
    }
  }
}
