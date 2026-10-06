import 'package:flutter/material.dart';
import 'package:flutter_profile/constants.dart';

import 'hero_banner_helpers.dart';
import 'hero_banner_meta_info.dart';
import 'quick_action_link_buttons.dart';

import 'hero_banner_background.dart';

class HeroBanner extends StatelessWidget {
  final Project project;
  final bool isMobile;
  final VoidCallback? onClose;
  final VoidCallback? onScrollDown;

  const HeroBanner({
    Key? key,
    required this.project,
    required this.isMobile,
    this.onClose,
    this.onScrollDown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hPad = isMobile ? 20.0 : 56.0;
    final minHeight = isMobile ? 360.0 : 460.0;
    final category = project.categories.isNotEmpty
        ? project.categories.first.toUpperCase()
        : 'PROJECT';

    return Stack(
      children: [
        Positioned.fill(
          child: HeroBannerBackground(imagePath: project.image),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(minHeight: minHeight),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: hPad, vertical: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [GlassCloseButton(onClose: onClose)],
                ),
              ),
              SizedBox(height: isMobile ? 40 : 80),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: hPad),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$category',
                          style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: isMobile ? double.infinity : 620),
                      child: Text(
                        project.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isMobile ? 28 : 46,
                          fontWeight: FontWeight.w800,
                          height: 1.12,
                          letterSpacing: -0.8,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 12,
                      runSpacing: 10,
                      children: [
                        ProjectTagPill(
                          icon: Icons.calendar_today_rounded,
                          label: project.displayYear,
                        ),
                        if (project.displayRole.isNotEmpty)
                          ProjectTagPill(
                            icon: Icons.person_outline_rounded,
                            label: project.displayRole,
                          ),
                        ...project.displayTypes.map(
                          (type) => ProjectTagPill(
                            icon: HeroBannerBackground.getPlatformIcon(type),
                            label: type,
                          ),
                        ),
                      ],
                    ),
                    QuickActionLinkButtons(project: project),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.only(right: hPad, bottom: 12),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ScrollDownDot(onTap: onScrollDown),
                ),
              ),
              HeroBannerMetaInfo(project: project, isMobile: isMobile),
            ],
          ),
        ),
      ],
    );
  }
}
