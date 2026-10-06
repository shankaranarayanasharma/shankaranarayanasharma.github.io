import 'package:flutter/material.dart';

class MetaCol extends StatelessWidget {
  final String label;
  final Widget child;
  const MetaCol({Key? key, required this.label, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label,
            style: const TextStyle(
              color: Colors.white38,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.4,
            )),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}

class ScrollDownDot extends StatefulWidget {
  final VoidCallback? onTap;
  const ScrollDownDot({Key? key, this.onTap}) : super(key: key);

  @override
  State<ScrollDownDot> createState() => _ScrollDownDotState();
}

class _ScrollDownDotState extends State<ScrollDownDot> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _hovered
                ? Colors.white.withValues(alpha: 0.22)
                : Colors.white.withValues(alpha: 0.13),
            border: Border.all(
                color: Colors.white.withValues(alpha: 0.30), width: 1.2),
          ),
          child: const Icon(Icons.keyboard_arrow_down_rounded,
              color: Colors.white, size: 22),
        ),
      ),
    );
  }
}

class GlassCloseButton extends StatefulWidget {
  final VoidCallback? onClose;
  const GlassCloseButton({Key? key, this.onClose}) : super(key: key);

  @override
  State<GlassCloseButton> createState() => _GlassCloseButtonState();
}

class _GlassCloseButtonState extends State<GlassCloseButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onClose ?? () => Navigator.maybePop(context),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: _hovered
                ? Colors.white.withValues(alpha: 0.22)
                : Colors.white.withValues(alpha: 0.11),
            shape: BoxShape.circle,
            border: Border.all(
                color: Colors.white.withValues(alpha: 0.28), width: 1),
          ),
          child: Icon(
            widget.onClose != null
                ? Icons.close_rounded
                : Icons.arrow_back_rounded,
            color: Colors.white,
            size: 18,
          ),
        ),
      ),
    );
  }
}

class ProjectTagPill extends StatelessWidget {
  final IconData icon;
  final String label;

  const ProjectTagPill({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 15,
            color: const Color(0xFF82ACF9),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
