import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_profile/constants.dart';

enum PlatformDeviceType {
  all,
  iPhone,
  android,
  tablet,
  iPad,
  macOS,
  web,
}

class ProjectMediaCarousel extends StatefulWidget {
  final List<String> media;
  final Map<String, List<String>>? mediaByPlatform;
  final String projectImage;

  const ProjectMediaCarousel({
    Key? key,
    required this.media,
    this.mediaByPlatform,
    this.projectImage = "",
  }) : super(key: key);

  @override
  State<ProjectMediaCarousel> createState() => _ProjectMediaCarouselState();
}

class _ProjectMediaCarouselState extends State<ProjectMediaCarousel> {
  final ScrollController _scrollController = ScrollController();
  Map<String, List<String>> _loadedMediaByPlatform = {};
  String _selectedPlatform = "";
  bool _isLoadingAssets = true;

  @override
  void initState() {
    super.initState();
    _loadAssetManifest();
  }

  @override
  void didUpdateWidget(ProjectMediaCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.projectImage != widget.projectImage ||
        oldWidget.mediaByPlatform != widget.mediaByPlatform ||
        oldWidget.media != widget.media) {
      _loadAssetManifest();
    }
  }

  Future<void> _loadAssetManifest() async {
    setState(() => _isLoadingAssets = true);

    Map<String, List<String>> result = {};

    // 1. If explicit mediaByPlatform is provided and non-empty, use it directly
    if (widget.mediaByPlatform != null && widget.mediaByPlatform!.isNotEmpty) {
      result = Map.from(widget.mediaByPlatform!);
    } else {
      // 2. Scan AssetManifest.json for subfolders matching projectImage directory
      String baseFolder = "";
      final lastSlash = widget.projectImage.lastIndexOf('/');
      if (lastSlash != -1) {
        baseFolder = widget.projectImage.substring(0, lastSlash + 1);
      }

      final allAssets = await _getAllAssetKeys();

      for (final path in allAssets) {
        if (baseFolder.isNotEmpty && !path.startsWith(baseFolder)) {
          continue;
        }
        if (path == widget.projectImage) continue;

        final lower = path.toLowerCase();
        String? platformKey;
        if (lower.contains('/android/') || lower.contains('_android')) {
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
          result.putIfAbsent(platformKey, () => []).add(path);
        }
      }

      // 3. Fallback to explicit widget.media if no subfolder assets discovered
      if (result.isEmpty && widget.media.isNotEmpty) {
        for (final path in widget.media) {
          final lower = path.toLowerCase();
          String platformKey = "Android";
          if (lower.contains('/iphone/') || lower.contains('/ios/')) {
            platformKey = "iPhone";
          } else if (lower.contains('/ipad/')) {
            platformKey = "iPad";
          } else if (lower.contains('/tablet/')) {
            platformKey = "Tablet";
          } else if (lower.contains('/macos/') || lower.contains('/mac/')) {
            platformKey = "Mac OS";
          } else if (lower.contains('/web/')) {
            platformKey = "Web";
          }
          result.putIfAbsent(platformKey, () => []).add(path);
        }
      }
    }

    if (mounted) {
      setState(() {
        _loadedMediaByPlatform = result;
        _isLoadingAssets = false;
        final platforms = _availablePlatforms;
        if (platforms.isNotEmpty) {
          _selectedPlatform = platforms.first;
        } else {
          _selectedPlatform = "";
        }
      });
    }
  }

  int _getPlatformPriority(String platform) {
    final lower = platform.toLowerCase();
    if (lower.contains("android")) return 0;
    if (lower.contains("iphone") || lower.contains("ios")) return 1;
    if (lower.contains("tablet")) return 2;
    if (lower.contains("ipad")) return 3;
    if (lower.contains("web")) return 4;
    if (lower.contains("desktop") || lower.contains("mac")) return 5;
    return 6;
  }

  Future<List<String>> _getAllAssetKeys() async {
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

  List<String> get _availablePlatforms {
    final keys = _loadedMediaByPlatform.keys.toList();
    keys.sort((a, b) => _getPlatformPriority(a).compareTo(_getPlatformPriority(b)));
    return keys;
  }

  List<String> get _currentMediaList {
    if (_loadedMediaByPlatform.containsKey(_selectedPlatform)) {
      return _loadedMediaByPlatform[_selectedPlatform]!;
    }
    return widget.media;
  }

  PlatformDeviceType _getDeviceTypeForMedia(String mediaUrl, int index) {
    return _parseDeviceType(_selectedPlatform);
  }

  PlatformDeviceType _parseDeviceType(String platformName) {
    final lower = platformName.toLowerCase();
    if (lower.contains("iphone") || lower.contains("ios")) return PlatformDeviceType.iPhone;
    if (lower.contains("android")) return PlatformDeviceType.android;
    if (lower.contains("ipad")) return PlatformDeviceType.iPad;
    if (lower.contains("tablet")) return PlatformDeviceType.tablet;
    if (lower.contains("mac") || lower.contains("desktop")) return PlatformDeviceType.macOS;
    if (lower.contains("web") || lower.contains("browser")) return PlatformDeviceType.web;
    return PlatformDeviceType.iPhone;
  }

  IconData _getIconForPlatform(String platform) {
    final lower = platform.toLowerCase();
    if (lower.contains("android")) return Icons.android_rounded;
    if (lower.contains("iphone") || lower.contains("ios")) return Icons.phone_iphone_rounded;
    if (lower.contains("ipad")) return Icons.tablet_mac_rounded;
    if (lower.contains("tablet")) return Icons.tablet_rounded;
    if (lower.contains("mac")) return Icons.laptop_mac_rounded;
    if (lower.contains("web")) return Icons.language_rounded;
    return Icons.view_carousel_rounded;
  }

  Widget _buildImage(String path, {BoxFit fit = BoxFit.contain}) {
    if (path.startsWith("assets/")) {
      return Image.asset(
        path,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _errorPlaceholder(),
      );
    } else {
      return Image.network(
        path,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _errorPlaceholder(),
      );
    }
  }

  Widget _errorPlaceholder() {
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

  Widget _buildMockupForFullView(String path, int index) {
    final deviceType = _getDeviceTypeForMedia(path, index);
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
        _buildImage(path, fit: BoxFit.fill),
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

    switch (deviceType) {
      case PlatformDeviceType.android:
        return _AndroidMockupFrame(
          isHovered: false,
          isVideo: isVideo,
          margin: EdgeInsets.zero,
          child: imageWidget,
        );
      case PlatformDeviceType.tablet:
        return _TabletMockupFrame(
          isHovered: false,
          isVideo: isVideo,
          margin: EdgeInsets.zero,
          child: imageWidget,
        );
      case PlatformDeviceType.iPad:
        return _IPadMockupFrame(
          isHovered: false,
          isVideo: isVideo,
          margin: EdgeInsets.zero,
          child: imageWidget,
        );
      case PlatformDeviceType.macOS:
        return _MacOSMockupFrame(
          isHovered: false,
          isVideo: isVideo,
          margin: EdgeInsets.zero,
          child: imageWidget,
        );
      case PlatformDeviceType.web:
        return _WebMockupFrame(
          isHovered: false,
          isVideo: isVideo,
          margin: EdgeInsets.zero,
          child: imageWidget,
        );
      case PlatformDeviceType.all:
      case PlatformDeviceType.iPhone:
      default:
        return _IPhoneMockupFrame(
          isHovered: false,
          isVideo: isVideo,
          margin: EdgeInsets.zero,
          child: imageWidget,
        );
    }
  }

  void _openFullView(BuildContext context, int initialIndex, List<String> currentList) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.85),
      builder: (context) {
        int currentIndex = initialIndex;
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final screenSize = MediaQuery.of(context).size;
            final maxMockupHeight = screenSize.height * 0.85;
            final maxMockupWidth = screenSize.width * 0.88;

            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  InteractiveViewer(
                    maxScale: 3.0,
                    child: SizedBox(
                      width: maxMockupWidth,
                      height: maxMockupHeight,
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: _buildMockupForFullView(
                            currentList[currentIndex],
                            currentIndex,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close_rounded,
                            color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                  if (currentList.length > 1) ...[
                    Positioned(
                      left: 0,
                      child: IconButton(
                        onPressed: () {
                          setDialogState(() {
                            currentIndex = (currentIndex - 1 + currentList.length) %
                                currentList.length;
                          });
                        },
                        icon: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.chevron_left_rounded,
                              color: Colors.white, size: 28),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                          setDialogState(() {
                            currentIndex =
                                (currentIndex + 1) % currentList.length;
                          });
                        },
                        icon: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.chevron_right_rounded,
                              color: Colors.white, size: 28),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingAssets) {
      return const SizedBox(
        height: 100,
        child: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
          ),
        ),
      );
    }

    final mediaList = _currentMediaList;
    final platforms = _availablePlatforms;

    if (mediaList.isEmpty && platforms.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Top Platform Filter Tab Bar ─────────────────────
        if (platforms.isNotEmpty)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: platforms.map((platform) {
                final isSelected = _selectedPlatform == platform;
                final iconData = _getIconForPlatform(platform);
                final count = _loadedMediaByPlatform[platform]?.length ?? 0;

                return Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 16),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedPlatform = platform;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? primaryColor.withValues(alpha: 0.18)
                              : const Color(0xFF18181C),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? primaryColor
                                : Colors.white.withValues(alpha: 0.08),
                            width: isSelected ? 1.5 : 1.0,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: primaryColor.withValues(alpha: 0.25),
                                    blurRadius: 12,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : [],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              iconData,
                              size: 15,
                              color: isSelected
                                  ? primaryColor
                                  : Colors.white60,
                            ),
                            const SizedBox(width: 7),
                            Text(
                              platform,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.white70,
                              ),
                            ),
                            if (count > 0) ...[
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? primaryColor.withValues(alpha: 0.3)
                                      : Colors.white.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  "$count",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? primaryColor
                                        : Colors.white38,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

        // ── Media Carousel List ────────────────────────────
        if (mediaList.isNotEmpty)
          SizedBox(
            height: 500,
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: false,
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: mediaList.length,
                itemBuilder: (context, index) {
                  final deviceType =
                      _getDeviceTypeForMedia(mediaList[index], index);
                  return _MediaCardItem(
                    mediaPath: mediaList[index],
                    buildImage: _buildImage,
                    deviceType: deviceType,
                    onTap: () => _openFullView(context, index, mediaList),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}

class _MediaCardItem extends StatefulWidget {
  final String mediaPath;
  final Widget Function(String, {BoxFit fit}) buildImage;
  final VoidCallback onTap;
  final PlatformDeviceType deviceType;

  const _MediaCardItem({
    required this.mediaPath,
    required this.buildImage,
    required this.onTap,
    required this.deviceType,
  });

  @override
  State<_MediaCardItem> createState() => _MediaCardItemState();
}

class _MediaCardItemState extends State<_MediaCardItem> {
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
    Widget frameWidget;
    switch (widget.deviceType) {
      case PlatformDeviceType.android:
        frameWidget = _AndroidMockupFrame(
            isHovered: _hovered, isVideo: _isVideo, child: _buildContent());
        break;
      case PlatformDeviceType.tablet:
        frameWidget = _TabletMockupFrame(
            isHovered: _hovered, isVideo: _isVideo, child: _buildContent());
        break;
      case PlatformDeviceType.iPad:
        frameWidget = _IPadMockupFrame(
            isHovered: _hovered, isVideo: _isVideo, child: _buildContent());
        break;
      case PlatformDeviceType.macOS:
        frameWidget = _MacOSMockupFrame(
            isHovered: _hovered, isVideo: _isVideo, child: _buildContent());
        break;
      case PlatformDeviceType.web:
        frameWidget = _WebMockupFrame(
            isHovered: _hovered, isVideo: _isVideo, child: _buildContent());
        break;
      case PlatformDeviceType.all:
      case PlatformDeviceType.iPhone:
      default:
        frameWidget = _IPhoneMockupFrame(
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

// ════════════════════════════════════════════════════════════════════
// 1. iPHONE MOCKUP FRAME
// ════════════════════════════════════════════════════════════════════
class _IPhoneMockupFrame extends StatelessWidget {
  final Widget child;
  final bool isHovered;
  final bool isVideo;
  final EdgeInsetsGeometry margin;

  const _IPhoneMockupFrame({
    Key? key,
    required this.child,
    required this.isHovered,
    this.isVideo = false,
    this.margin = const EdgeInsets.only(right: 22, bottom: 10, top: 4),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderColor = isHovered
        ? primaryColor.withValues(alpha: 0.85)
        : const Color(0xFF32323A);
    final glowColor = isHovered
        ? primaryColor.withValues(alpha: 0.25)
        : Colors.black.withValues(alpha: 0.5);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 235,
      height: 470,
      margin: margin,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1E),
        borderRadius: BorderRadius.circular(44),
        border: Border.all(
          color: borderColor,
          width: isHovered ? 2.5 : 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: glowColor,
            blurRadius: isHovered ? 24 : 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: -4,
            top: 75,
            child: Container(
              width: 3,
              height: 22,
              decoration: BoxDecoration(
                color: const Color(0xFF383840),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Positioned(
            left: -4,
            top: 110,
            child: Container(
              width: 3,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF383840),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Positioned(
            left: -4,
            top: 160,
            child: Container(
              width: 3,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF383840),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Positioned(
            right: -4,
            top: 125,
            child: Container(
              width: 3,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFF383840),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(37),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(37),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    child,
                    Positioned(
                      top: 8,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 82,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.5),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0F172A),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFF1E293B),
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 3,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 36,
                          height: 2.5,
                          decoration: BoxDecoration(
                            color: const Color(0xFF333338),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 7,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 95,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════
// 2. ANDROID MOCKUP FRAME
// ════════════════════════════════════════════════════════════════════
class _AndroidMockupFrame extends StatelessWidget {
  final Widget child;
  final bool isHovered;
  final bool isVideo;
  final EdgeInsetsGeometry margin;

  const _AndroidMockupFrame({
    Key? key,
    required this.child,
    required this.isHovered,
    this.isVideo = false,
    this.margin = const EdgeInsets.only(right: 22, bottom: 10, top: 4),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderColor = isHovered
        ? const Color(0xFF38BDF8).withValues(alpha: 0.85)
        : const Color(0xFF2C2C34);
    final glowColor = isHovered
        ? const Color(0xFF38BDF8).withValues(alpha: 0.25)
        : Colors.black.withValues(alpha: 0.5);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 235,
      height: 470,
      margin: margin,
      decoration: BoxDecoration(
        color: const Color(0xFF18181C),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: borderColor,
          width: isHovered ? 2.5 : 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: glowColor,
            blurRadius: isHovered ? 24 : 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -4,
            top: 100,
            child: Container(
              width: 3,
              height: 38,
              decoration: BoxDecoration(
                color: const Color(0xFF383840),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Positioned(
            right: -4,
            top: 148,
            child: Container(
              width: 3,
              height: 65,
              decoration: BoxDecoration(
                color: const Color(0xFF383840),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(23),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(23),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    child,
                    Positioned(
                      top: 10,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 13,
                          height: 13,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF1E293B),
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: Container(
                              width: 4,
                              height: 4,
                              decoration: const BoxDecoration(
                                color: Color(0xFF0F172A),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 3,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 30,
                          height: 2,
                          decoration: BoxDecoration(
                            color: const Color(0xFF333338),
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 80,
                          height: 3,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.55),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════
// 3. iPAD MOCKUP FRAME
// ════════════════════════════════════════════════════════════════════
class _IPadMockupFrame extends StatelessWidget {
  final Widget child;
  final bool isHovered;
  final bool isVideo;
  final EdgeInsetsGeometry margin;

  const _IPadMockupFrame({
    Key? key,
    required this.child,
    required this.isHovered,
    this.isVideo = false,
    this.margin = const EdgeInsets.only(right: 22, bottom: 10, top: 4),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderColor = isHovered
        ? primaryColor.withValues(alpha: 0.85)
        : const Color(0xFF32323A);
    final glowColor = isHovered
        ? primaryColor.withValues(alpha: 0.25)
        : Colors.black.withValues(alpha: 0.5);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 360,
      height: 470,
      margin: margin,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E22),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: borderColor,
          width: isHovered ? 2.5 : 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: glowColor,
            blurRadius: isHovered ? 24 : 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(18),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    child,
                    Positioned(
                      top: 6,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            color: Color(0xFF1E293B),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 6,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 120,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════
// 4. TABLET MOCKUP FRAME
// ════════════════════════════════════════════════════════════════════
class _TabletMockupFrame extends StatelessWidget {
  final Widget child;
  final bool isHovered;
  final bool isVideo;
  final EdgeInsetsGeometry margin;

  const _TabletMockupFrame({
    Key? key,
    required this.child,
    required this.isHovered,
    this.isVideo = false,
    this.margin = const EdgeInsets.only(right: 22, bottom: 10, top: 4),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderColor = isHovered
        ? const Color(0xFF38BDF8).withValues(alpha: 0.85)
        : const Color(0xFF2C2C34);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 360,
      height: 470,
      margin: margin,
      decoration: BoxDecoration(
        color: const Color(0xFF161619),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: borderColor,
          width: isHovered ? 2.5 : 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: isHovered
                ? const Color(0xFF38BDF8).withValues(alpha: 0.25)
                : Colors.black.withValues(alpha: 0.5),
            blurRadius: isHovered ? 24 : 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            fit: StackFit.expand,
            children: [
              child,
              Positioned(
                top: 8,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF0F172A),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 90,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════
// 5. MAC OS MOCKUP FRAME
// ════════════════════════════════════════════════════════════════════
class _MacOSMockupFrame extends StatelessWidget {
  final Widget child;
  final bool isHovered;
  final bool isVideo;
  final EdgeInsetsGeometry margin;

  const _MacOSMockupFrame({
    Key? key,
    required this.child,
    required this.isHovered,
    this.isVideo = false,
    this.margin = const EdgeInsets.only(right: 22, bottom: 10, top: 4),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderColor = isHovered
        ? primaryColor.withValues(alpha: 0.85)
        : const Color(0xFF2C2C34);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 500,
      height: 370,
      margin: margin,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E24),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: borderColor,
          width: isHovered ? 2.0 : 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: isHovered
                ? primaryColor.withValues(alpha: 0.2)
                : Colors.black.withValues(alpha: 0.5),
            blurRadius: isHovered ? 24 : 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 34,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: const BoxDecoration(
              color: Color(0xFF16161B),
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            ),
            child: Row(
              children: [
                Container(
                    width: 11,
                    height: 11,
                    decoration: const BoxDecoration(
                        color: Color(0xFFFF5F56), shape: BoxShape.circle)),
                const SizedBox(width: 7),
                Container(
                    width: 11,
                    height: 11,
                    decoration: const BoxDecoration(
                        color: Color(0xFFFFBD2E), shape: BoxShape.circle)),
                const SizedBox(width: 7),
                Container(
                    width: 11,
                    height: 11,
                    decoration: const BoxDecoration(
                        color: Color(0xFF27C93F), shape: BoxShape.circle)),
                const SizedBox(width: 16),
                const Expanded(
                  child: Center(
                    child: Text(
                      "macOS App Showcase",
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 50),
              ],
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(15)),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════
// 6. WEB BROWSER MOCKUP FRAME
// ════════════════════════════════════════════════════════════════════
class _WebMockupFrame extends StatelessWidget {
  final Widget child;
  final bool isHovered;
  final bool isVideo;
  final EdgeInsetsGeometry margin;

  const _WebMockupFrame({
    Key? key,
    required this.child,
    required this.isHovered,
    this.isVideo = false,
    this.margin = const EdgeInsets.only(right: 22, bottom: 10, top: 4),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderColor = isHovered
        ? const Color(0xFF60A5FA).withValues(alpha: 0.85)
        : const Color(0xFF2C2C34);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 500,
      height: 370,
      margin: margin,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E24),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: borderColor,
          width: isHovered ? 2.0 : 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: isHovered
                ? const Color(0xFF60A5FA).withValues(alpha: 0.2)
                : Colors.black.withValues(alpha: 0.5),
            blurRadius: isHovered ? 24 : 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF141418),
              borderRadius: BorderRadius.vertical(top: Radius.circular(13)),
            ),
            child: Row(
              children: [
                Row(
                  children: [
                    Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                            color: Color(0xFFFF5F56), shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                            color: Color(0xFFFFBD2E), shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                            color: Color(0xFF27C93F), shape: BoxShape.circle)),
                  ],
                ),
                const SizedBox(width: 14),
                const Icon(Icons.arrow_back_rounded,
                    color: Colors.white38, size: 14),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward_rounded,
                    color: Colors.white38, size: 14),
                const SizedBox(width: 8),
                const Icon(Icons.refresh_rounded,
                    color: Colors.white38, size: 14),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 24,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF22222A),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.lock_rounded,
                            color: Colors.white38, size: 10),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            "https://localhost:8080/app",
                            style: TextStyle(
                                color: Colors.white60, fontSize: 10),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(13)),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
