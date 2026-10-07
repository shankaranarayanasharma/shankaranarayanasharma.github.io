import 'package:flutter/material.dart';
import 'package:flutter_profile/models/Project.dart';

class MediaBlockRenderer {
  static Widget buildSmartImage(String url, {BoxFit fit = BoxFit.cover}) {
    if (url.startsWith('assets/')) {
      return Image.asset(
        url,
        fit: fit,
        errorBuilder: (_, __, ___) => Container(
          height: 160,
          color: Colors.white.withValues(alpha: 0.05),
          child: const Center(
            child: Icon(Icons.image_outlined, color: Colors.white38),
          ),
        ),
      );
    }
    return Image.network(
      url,
      fit: fit,
      errorBuilder: (_, __, ___) => Container(
        height: 160,
        color: Colors.white.withValues(alpha: 0.05),
        child: const Center(
          child: Icon(Icons.image_outlined, color: Colors.white38),
        ),
      ),
    );
  }

  static Widget buildSingleImage(NarrativeBlock block) {
    if (block.url == null || block.url!.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.1),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: buildSmartImage(block.url!),
            ),
          ),
          if (block.caption != null && block.caption!.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              block.caption!,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 11.5,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  static Widget buildMultipleImages(NarrativeBlock block) {
    if (block.urls == null || block.urls!.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: block.urls!.map((u) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 180,
                  height: 120,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                      width: 1,
                    ),
                  ),
                  child: buildSmartImage(u),
                ),
              );
            }).toList(),
          ),
          if (block.caption != null && block.caption!.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              block.caption!,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 11.5,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  static Widget buildVideo(NarrativeBlock block, Color accentColor) {
    if (block.url == null || block.url!.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF101014),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: accentColor.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.movie_creation_outlined,
                    size: 60,
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: accentColor.withValues(alpha: 0.6),
                        width: 1.5,
                      ),
                    ),
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: accentColor,
                      size: 32,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (block.caption != null && block.caption!.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              block.caption!,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 11.5,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
