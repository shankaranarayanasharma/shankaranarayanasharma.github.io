import 'package:flutter/material.dart';
import 'package:flutter_profile/models/Project.dart';

import 'block_content_renderer.dart';
import 'collapsible_content_box.dart';

class TextNarrativeBlock extends StatelessWidget {
  final String label;
  final IconData icon;
  final List<NarrativeBlock> blocks;
  final Color accentColor;
  final bool usePointByPoint;

  const TextNarrativeBlock({
    Key? key,
    required this.label,
    required this.icon,
    required this.blocks,
    this.accentColor = const Color(0xFF60A5FA),
    this.usePointByPoint = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.white.withValues(alpha: 0.1),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Icon(icon, color: Colors.white70, size: 15),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          CollapsibleContentBox(
            collapsedMaxHeight: 145,
            fadeColor: const Color(0xFF0D0D11),
            child: BlockContentRenderer(
              blocks: blocks,
              accentColor: accentColor,
              forcePointByPoint: usePointByPoint,
            ),
          ),
        ],
      ),
    );
  }
}

class CardNarrativeBlock extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final List<NarrativeBlock> blocks;
  final bool usePointByPoint;

  const CardNarrativeBlock({
    Key? key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.blocks,
    this.usePointByPoint = false,
  }) : super(key: key);

  @override
  State<CardNarrativeBlock> createState() => _CardNarrativeBlockState();
}

class _CardNarrativeBlockState extends State<CardNarrativeBlock> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final cardBgColor =
        _hovered ? const Color(0xFF1F1F24) : const Color(0xFF161619);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: cardBgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered
                ? widget.iconColor.withValues(alpha: 0.4)
                : Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? widget.iconColor.withValues(alpha: 0.08)
                  : Colors.black.withValues(alpha: 0.3),
              blurRadius: _hovered ? 20 : 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: widget.iconColor.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.icon,
                    color: widget.iconColor,
                    size: 17,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            CollapsibleContentBox(
              collapsedMaxHeight: 145,
              fadeColor: cardBgColor,
              child: BlockContentRenderer(
                blocks: widget.blocks,
                accentColor: widget.iconColor,
                forcePointByPoint: widget.usePointByPoint,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
