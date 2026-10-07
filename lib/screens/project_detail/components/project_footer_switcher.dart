import 'package:flutter/material.dart';
import 'package:flutter_profile/constants.dart';

class ProjectFooterSwitcher extends StatelessWidget {
  final Project prevProject;
  final Project nextProject;
  final Function(Project) onSelectProject;
  final bool isMobile;

  const ProjectFooterSwitcher({
    Key? key,
    required this.prevProject,
    required this.nextProject,
    required this.onSelectProject,
    required this.isMobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: 24,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF101012),
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: NavProjectButton(
              project: prevProject,
              isNext: false,
              isMobile: isMobile,
              onTap: () => onSelectProject(prevProject),
            ),
          ),
          const SizedBox(width: 16),
          Flexible(
            child: NavProjectButton(
              project: nextProject,
              isNext: true,
              isMobile: isMobile,
              onTap: () => onSelectProject(nextProject),
            ),
          ),
        ],
      ),
    );
  }
}

class NavProjectButton extends StatefulWidget {
  final Project project;
  final bool isNext;
  final bool isMobile;
  final VoidCallback onTap;

  const NavProjectButton({
    Key? key,
    required this.project,
    required this.isNext,
    required this.isMobile,
    required this.onTap,
  }) : super(key: key);

  @override
  State<NavProjectButton> createState() => _NavProjectButtonState();
}

class _NavProjectButtonState extends State<NavProjectButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final title = widget.project.title.toUpperCase();

    final circleBtn = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _hovered
            ? primaryColor.withValues(alpha: 0.2)
            : Colors.white.withValues(alpha: 0.08),
        border: Border.all(
          color: _hovered
              ? primaryColor.withValues(alpha: 0.6)
              : Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Icon(
        widget.isNext
            ? Icons.arrow_forward_rounded
            : Icons.arrow_back_rounded,
        color: _hovered ? primaryColor : Colors.white,
        size: 18,
      ),
    );

    final titleText = Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: _hovered ? primaryColor : Colors.white70,
        fontSize: widget.isMobile ? 11 : 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
        fontFamily: 'monospace',
      ),
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: widget.isNext ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: widget.isNext
              ? [
                  Flexible(child: titleText),
                  const SizedBox(width: 12),
                  circleBtn,
                ]
              : [
                  circleBtn,
                  const SizedBox(width: 12),
                  Flexible(child: titleText),
                ],
        ),
      ),
    );
  }
}
