import 'package:flutter/material.dart';
import 'package:flutter_profile/models/Project.dart';
import 'media_block_renderer.dart';
import 'points_renderer.dart';

class BlockContentRenderer extends StatelessWidget {
  final List<NarrativeBlock> blocks;
  final Color accentColor;
  final bool forcePointByPoint;

  const BlockContentRenderer({
    Key? key,
    required this.blocks,
    required this.accentColor,
    this.forcePointByPoint = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (blocks.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: blocks.map((block) {
        switch (block.type) {
          case NarrativeBlockType.heading:
            if (block.text == null || block.text!.trim().isEmpty) {
              return const SizedBox();
            }
            return Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 10.0),
              child: Text(
                block.text!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                  letterSpacing: -0.4,
                ),
              ),
            );

          case NarrativeBlockType.paragraph:
            if (block.text == null || block.text!.trim().isEmpty) {
              return const SizedBox();
            }
            if (forcePointByPoint) {
              final pts = _extractSentences(block.text!);
              return PointsRenderer(items: pts, tint: accentColor, iconStyle: null);
            }
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(
                block.text!,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 13.5,
                  height: 1.7,
                ),
              ),
            );

          case NarrativeBlockType.points:
            if (block.items == null || block.items!.isEmpty) {
              return const SizedBox();
            }
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: PointsRenderer(items: block.items!, tint: accentColor, iconStyle: block.iconStyle),
            );

          case NarrativeBlockType.image:
            return MediaBlockRenderer.buildSingleImage(block);

          case NarrativeBlockType.images:
            return MediaBlockRenderer.buildMultipleImages(block);

          case NarrativeBlockType.video:
            return MediaBlockRenderer.buildVideo(block, accentColor);
        }
      }).toList(),
    );
  }

  List<String> _extractSentences(String text) {
    if (text.trim().isEmpty) return [];
    final lines = text.split('\n').where((l) => l.trim().isNotEmpty).toList();
    if (lines.length > 1) {
      return lines
          .map((l) => l.replaceAll(RegExp(r'^[\s•\-\*\d+\.]+\s*'), '').trim())
          .where((l) => l.isNotEmpty)
          .toList();
    }
    if (text.contains(';')) {
      final semiSplit = text
          .split(';')
          .map((s) => s.replaceAll(RegExp(r'^[\s•\-\*\d+\.]+\s*'), '').trim())
          .where((s) => s.isNotEmpty)
          .toList();
      if (semiSplit.length > 1) return semiSplit;
    }
    final sentences = text.split(RegExp(r'(?<=[.!?])\s+'));
    final result = sentences
        .map((s) => s.replaceAll(RegExp(r'^[\s•\-\*\d+\.]+\s*'), '').trim())
        .where((s) => s.isNotEmpty)
        .toList();
    return result.isNotEmpty ? result : [text];
  }
}
