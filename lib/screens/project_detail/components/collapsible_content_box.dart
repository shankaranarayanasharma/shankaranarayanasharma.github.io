import 'package:flutter/material.dart';

class MeasureSize extends StatefulWidget {
  final Widget child;
  final ValueChanged<Size> onChange;

  const MeasureSize({Key? key, required this.child, required this.onChange})
      : super(key: key);

  @override
  State<MeasureSize> createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<MeasureSize> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final size = context.size;
        if (size != null) {
          widget.onChange(size);
        }
      }
    });
    return widget.child;
  }
}

class CollapsibleContentBox extends StatefulWidget {
  final Widget child;
  final double collapsedMaxHeight;
  final Color fadeColor;

  const CollapsibleContentBox({
    Key? key,
    required this.child,
    this.collapsedMaxHeight = 160.0,
    this.fadeColor = Colors.transparent,
  }) : super(key: key);

  @override
  State<CollapsibleContentBox> createState() => _CollapsibleContentBoxState();
}

class _CollapsibleContentBoxState extends State<CollapsibleContentBox> {
  bool _expanded = false;
  bool _btnHovered = false;
  double? _childHeight;

  @override
  Widget build(BuildContext context) {
    final isOverflowing = _childHeight != null &&
        _childHeight! > (widget.collapsedMaxHeight + 5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          child: (!isOverflowing || _expanded)
              ? MeasureSize(
                  onChange: (size) {
                    if (_childHeight != size.height) {
                      setState(() => _childHeight = size.height);
                    }
                  },
                  child: widget.child,
                )
              : ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: widget.collapsedMaxHeight,
                  ),
                  child: ClipRect(
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: MeasureSize(
                            onChange: (size) {
                              if (_childHeight != size.height) {
                                setState(() => _childHeight = size.height);
                              }
                            },
                            child: widget.child,
                          ),
                        ),
                        if (widget.fadeColor != Colors.transparent)
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            height: 36,
                            child: IgnorePointer(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      widget.fadeColor.withValues(alpha: 0.0),
                                      widget.fadeColor.withValues(alpha: 0.95),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
        ),
        if (isOverflowing) ...[
          const SizedBox(height: 8),
          MouseRegion(
            onEnter: (_) => setState(() => _btnHovered = true),
            onExit: (_) => setState(() => _btnHovered = false),
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => setState(() => _expanded = !_expanded),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
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
              ),
            ),
          ),
        ],
      ],
    );
  }
}
