import 'package:flutter/material.dart';

class ExpandableDescription extends StatefulWidget {
  final String text;

  const ExpandableDescription({Key? key, required this.text})
      : super(key: key);

  @override
  State<ExpandableDescription> createState() => _ExpandableDescriptionState();
}

class _ExpandableDescriptionState extends State<ExpandableDescription> {
  bool _expanded = false;
  bool _btnHovered = false;

  @override
  Widget build(BuildContext context) {
    final isLong = widget.text.length > 110 || widget.text.contains('\n');

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 820),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState: _expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: Text(
              widget.text,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14.5,
                height: 1.65,
                letterSpacing: 0.1,
              ),
            ),
            secondChild: Text(
              widget.text,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14.5,
                height: 1.65,
                letterSpacing: 0.1,
              ),
            ),
          ),
          if (isLong) ...[
            const SizedBox(height: 6),
            MouseRegion(
              onEnter: (_) => setState(() => _btnHovered = true),
              onExit: (_) => setState(() => _btnHovered = false),
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => setState(() => _expanded = !_expanded),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _expanded ? "See Less <<" : "See More >>",
                        style: TextStyle(
                          color: _btnHovered
                              ? const Color(0xFF60A5FA)
                              : const Color(0xFFF59E0B),
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
