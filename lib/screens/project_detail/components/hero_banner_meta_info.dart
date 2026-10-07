import 'package:flutter/material.dart';
import 'package:flutter_profile/models/Project.dart';

import 'hero_banner_helpers.dart';

class HeroBannerMetaInfo extends StatelessWidget {
  final Project project;
  final bool isMobile;

  const HeroBannerMetaInfo({
    Key? key,
    required this.project,
    required this.isMobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final platform = project.categories.join(' & ');
    final hPad = isMobile ? 20.0 : 56.0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 20),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        color: Colors.black.withValues(alpha: 0.40),
      ),
      child: isMobile
          ? Wrap(
              spacing: 28,
              runSpacing: 18,
              children: _metaItems(platform),
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _metaItemsWithDividers(platform),
            ),
    );
  }

  List<Widget> _metaItems(String platform) {
    final items = <Widget>[];

    final roleLabel = project.displayRole;
    if (roleLabel.isNotEmpty) {
      items.add(MetaCol(
        label: 'ROLE',
        child: Text(
          roleLabel,
          style: const TextStyle(
              color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ));
    }

    if (platform.isNotEmpty) {
      items.add(MetaCol(
        label: 'PLATFORM',
        child: Text(platform,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600)),
      ));
    }

    if (project.technologies.isNotEmpty) {
      items.add(MetaCol(
        label: 'TECH STACK',
        child: Wrap(
          spacing: 6,
          runSpacing: 4,
          children: project.technologies.take(6).map((t) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                    color: Colors.white.withValues(alpha: 0.18), width: 0.8),
              ),
              child: Text(t,
                  style: const TextStyle(color: Colors.white70, fontSize: 11)),
            );
          }).toList(),
        ),
      ));
    }

    return items;
  }

  List<Widget> _metaItemsWithDividers(String platform) {
    final items = _metaItems(platform);
    final result = <Widget>[];
    for (int i = 0; i < items.length; i++) {
      final isTechStack =
          project.technologies.isNotEmpty && i == items.length - 1;
      final wrapped = isTechStack
          ? Expanded(child: items[i])
          : i == 0
              ? ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 280),
                  child: items[i],
                )
              : items[i];
      result.add(wrapped);
      if (i < items.length - 1) {
        result.add(Container(
          height: 40,
          width: 1,
          margin: const EdgeInsets.symmetric(horizontal: 32),
          color: Colors.white.withValues(alpha: 0.12),
        ));
      }
    }
    if (project.technologies.isEmpty) {
      result.add(const Spacer());
    }
    return result;
  }
}
