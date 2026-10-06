import 'package:flutter/material.dart';
import 'package:flutter_profile/constants.dart';

import '../frames/android_mockup_frame.dart';
import '../frames/ipad_mockup_frame.dart';
import '../frames/iphone_mockup_frame.dart';
import '../frames/macos_mockup_frame.dart';
import '../frames/tablet_mockup_frame.dart';
import '../frames/web_mockup_frame.dart';
import '../project_media_carousel.dart';

class MediaCardItem extends StatefulWidget {
  final String mediaPath;
  final Widget Function(String, {BoxFit fit}) buildImage;
  final VoidCallback onTap;
  final PlatformDeviceType deviceType;
  final bool mediaHasBezel;

  const MediaCardItem({
    Key? key,
    required this.mediaPath,
    required this.buildImage,
    required this.onTap,
    required this.deviceType,
    this.mediaHasBezel = false,
  }) : super(key: key);

  @override
  State<MediaCardItem> createState() => _MediaCardItemState();
}

class _MediaCardItemState extends State<MediaCardItem> {
  bool _hovered = false;

  bool get _isVideo {
    final lower = widget.mediaPath.toLowerCase();
    return lower.endsWith('.mp4') ||
        lower.endsWith('.mov') ||
        lower.endsWith('.webm') ||
        lower.endsWith('.m4v') ||
        lower.endsWith('.avi') ||
        lower.contains('youtube.com') ||
        lower.contains('vimeo.com') ||
        lower.contains('youtu.be');
  }

  Widget _buildContent({BoxFit fit = BoxFit.fill}) {
    return Stack(
      fit: StackFit.expand,
      children: [
        widget.buildImage(widget.mediaPath, fit: fit),
        if (_isVideo)
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
        AnimatedOpacity(
          duration: const Duration(milliseconds: 180),
          opacity: _hovered ? 1.0 : 0.0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.7),
                ],
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 22.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _isVideo
                          ? Icons.play_circle_fill_rounded
                          : Icons.zoom_in_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _isVideo ? "Play Video" : "Fullscreen",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.mediaHasBezel) {
      return MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.only(right: 22, bottom: 10, top: 4),
            child: SizedBox(
              width: 235,
              height: 470,
              child: _buildContent(),
            ),
          ),
        ),
      );
    }

    Widget frameWidget;
    switch (widget.deviceType) {
      case PlatformDeviceType.android:
        frameWidget = AndroidMockupFrame(
            isHovered: _hovered, isVideo: _isVideo, child: _buildContent());
        break;
      case PlatformDeviceType.tablet:
        frameWidget = TabletMockupFrame(
            isHovered: _hovered, isVideo: _isVideo, child: _buildContent());
        break;
      case PlatformDeviceType.iPad:
        frameWidget = IPadMockupFrame(
            isHovered: _hovered, isVideo: _isVideo, child: _buildContent());
        break;
      case PlatformDeviceType.macOS:
        frameWidget = MacOSMockupFrame(
            isHovered: _hovered, isVideo: _isVideo, child: _buildContent());
        break;
      case PlatformDeviceType.web:
        frameWidget = WebMockupFrame(
            isHovered: _hovered, isVideo: _isVideo, child: _buildContent());
        break;
      case PlatformDeviceType.all:
      case PlatformDeviceType.iPhone:
      default:
        frameWidget = IPhoneMockupFrame(
            isHovered: _hovered, isVideo: _isVideo, child: _buildContent());
        break;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: frameWidget,
      ),
    );
  }
}
