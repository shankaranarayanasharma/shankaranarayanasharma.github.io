import 'package:flutter/material.dart';
import 'package:flutter_profile/constants.dart';

import 'components/full_view_dialog.dart';
import 'components/media_card_item.dart';
import 'components/platform_filter_tabs.dart';
import 'services/asset_manifest_service.dart';

import 'helpers/carousel_helpers.dart';
export 'helpers/carousel_helpers.dart';

enum PlatformDeviceTypeAlias { none }

class ProjectMediaCarousel extends StatefulWidget {
  final List<String> media;
  final Map<String, List<String>>? mediaByPlatform;
  final String projectImage;
  final bool mediaHasBezel;

  const ProjectMediaCarousel({
    Key? key,
    required this.media,
    this.mediaByPlatform,
    this.projectImage = "",
    this.mediaHasBezel = false,
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

    if (widget.mediaByPlatform != null && widget.mediaByPlatform!.isNotEmpty) {
      result = Map.from(widget.mediaByPlatform!);
    } else {
      String baseFolder = "";
      final lastSlash = widget.projectImage.lastIndexOf('/');
      if (lastSlash != -1) {
        baseFolder = widget.projectImage.substring(0, lastSlash + 1);
      }

      final allAssets = await AssetManifestService.getAllAssetKeys();

      for (final path in allAssets) {
        if (baseFolder.isNotEmpty && !path.startsWith(baseFolder)) {
          continue;
        }
        if (path == widget.projectImage) continue;

        final platformKey = AssetManifestService.parsePlatformKey(path);
        if (platformKey != null) {
          result.putIfAbsent(platformKey, () => []).add(path);
        }
      }

      if (result.isEmpty && widget.media.isNotEmpty) {
        for (final path in widget.media) {
          final platformKey =
              AssetManifestService.parsePlatformKey(path) ?? "Android";
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

  List<String> get _availablePlatforms {
    final keys = _loadedMediaByPlatform.keys.toList();
    keys.sort((a, b) => CarouselHelpers.getPlatformPriority(a)
        .compareTo(CarouselHelpers.getPlatformPriority(b)));
    return keys;
  }

  List<String> get _currentMediaList {
    if (_loadedMediaByPlatform.containsKey(_selectedPlatform)) {
      return _loadedMediaByPlatform[_selectedPlatform]!;
    }
    return widget.media;
  }

  PlatformDeviceType _getDeviceTypeForMedia(String mediaUrl, int index) {
    return CarouselHelpers.getDeviceTypeForMedia(
        mediaUrl, index, _selectedPlatform);
  }

  void _openFullView(
      BuildContext context, int initialIndex, List<String> currentList) {
    FullViewDialog.open(
      context,
      initialIndex: initialIndex,
      currentList: currentList,
      getDeviceType: _getDeviceTypeForMedia,
      buildImage: CarouselHelpers.buildImage,
      mediaHasBezel: widget.mediaHasBezel,
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
        PlatformFilterTabs(
          platforms: platforms,
          selectedPlatform: _selectedPlatform,
          loadedMediaByPlatform: _loadedMediaByPlatform,
          onSelectPlatform: (platform) {
            setState(() {
              _selectedPlatform = platform;
            });
          },
          getIconForPlatform: CarouselHelpers.getIconForPlatform,
        ),
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
                  return MediaCardItem(
                    mediaPath: mediaList[index],
                    buildImage: CarouselHelpers.buildImage,
                    deviceType: deviceType,
                    mediaHasBezel: widget.mediaHasBezel,
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
