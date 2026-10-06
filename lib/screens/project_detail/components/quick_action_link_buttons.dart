import 'package:flutter/material.dart';
import 'package:flutter_profile/models/Project.dart';
import 'package:url_launcher/url_launcher.dart';

class QuickActionLinkButtons extends StatelessWidget {
  final Project project;

  const QuickActionLinkButtons({Key? key, required this.project})
      : super(key: key);

  bool get hasLinks =>
      (project.appStore != null && project.appStore!.trim().isNotEmpty) ||
      (project.playStore != null && project.playStore!.trim().isNotEmpty) ||
      (project.github != null && project.github!.trim().isNotEmpty);

  @override
  Widget build(BuildContext context) {
    if (!hasLinks) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.only(top: 14.0),
      child: Wrap(
        spacing: 12,
        runSpacing: 10,
        children: [
          if (project.appStore != null && project.appStore!.trim().isNotEmpty)
            ActionButton(
              label: "App Store",
              icon: Icons.apple,
              url: project.appStore!,
              accentColor: const Color(0xFF38BDF8),
            ),
          if (project.playStore != null && project.playStore!.trim().isNotEmpty)
            ActionButton(
              label: "Google Play",
              icon: Icons.play_arrow_rounded,
              url: project.playStore!,
              accentColor: const Color(0xFF34D399),
            ),
          if (project.github != null && project.github!.trim().isNotEmpty)
            ActionButton(
              label: "GitHub",
              icon: Icons.code_rounded,
              url: project.github!,
              accentColor: const Color(0xFFA78BFA),
            ),
        ],
      ),
    );
  }
}

class ActionButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final String url;
  final Color accentColor;

  const ActionButton({
    Key? key,
    required this.label,
    required this.icon,
    required this.url,
    required this.accentColor,
  }) : super(key: key);

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  bool _hovered = false;

  void _launch() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _launch,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: _hovered
                ? widget.accentColor.withValues(alpha: 0.18)
                : Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hovered
                  ? widget.accentColor.withValues(alpha: 0.6)
                  : Colors.white.withValues(alpha: 0.15),
              width: 1,
            ),
            boxShadow: [
              if (_hovered)
                BoxShadow(
                  color: widget.accentColor.withValues(alpha: 0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 16,
                color: _hovered ? widget.accentColor : Colors.white,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  color: _hovered ? widget.accentColor : Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                Icons.arrow_outward_rounded,
                size: 13,
                color: _hovered
                    ? widget.accentColor
                    : Colors.white.withValues(alpha: 0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
