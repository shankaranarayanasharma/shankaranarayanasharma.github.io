import 'package:flutter/material.dart';

import '../project_media_carousel.dart';
import 'full_view_mockup_builder.dart';

class FullViewDialog {
  static void open(
    BuildContext context, {
    required int initialIndex,
    required List<String> currentList,
    required PlatformDeviceType Function(String path, int index) getDeviceType,
    required Widget Function(String path, {BoxFit fit}) buildImage,
    required bool mediaHasBezel,
  }) {
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
                          child: FullViewMockupBuilder.buildMockup(
                            path: currentList[currentIndex],
                            index: currentIndex,
                            getDeviceType: getDeviceType,
                            buildImage: buildImage,
                            mediaHasBezel: mediaHasBezel,
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
                            currentIndex =
                                (currentIndex - 1 + currentList.length) %
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
}
