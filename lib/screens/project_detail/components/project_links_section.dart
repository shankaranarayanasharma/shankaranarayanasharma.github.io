import 'package:flutter/material.dart';
import 'package:flutter_profile/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectLinksSection extends StatelessWidget {
  final Project project;

  const ProjectLinksSection({
    Key? key,
    required this.project,
  }) : super(key: key);

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tiles = <Widget>[];

    if (project.github != null && project.github!.isNotEmpty) {
      tiles.add(_buildLinkTile("GitHub Repository", project.github!));
    }
    if (project.appStore != null && project.appStore!.isNotEmpty) {
      tiles.add(_buildLinkTile("Apple App Store Link", project.appStore!));
    }
    if (project.playStore != null && project.playStore!.isNotEmpty) {
      tiles.add(_buildLinkTile("Google Play Store Link", project.playStore!));
    }

    if (tiles.isEmpty) {
      tiles.add(
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF252528),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white12, width: 0.8),
          ),
          child: const Text(
            AppStrings.demoProjectLinksWarning,
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Text(
              AppStrings.links,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 6),
            Icon(Icons.link_rounded, color: Colors.grey, size: 18),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(color: Colors.white12),
        const SizedBox(height: 12),
        ...tiles,
      ],
    );
  }

  Widget _buildLinkTile(String name, String url) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _launchURL(url),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF252528),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white12, width: 0.8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: primaryColor,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
