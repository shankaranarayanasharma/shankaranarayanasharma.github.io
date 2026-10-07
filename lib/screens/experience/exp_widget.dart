import 'package:flutter/material.dart';
import 'package:flutter_profile/constants.dart';
import 'package:flutter_profile/responsive.dart';

class TimelineExperienceCard extends StatefulWidget {
  const TimelineExperienceCard({
    Key? key,
    required this.exp,
    required this.isLast,
  }) : super(key: key);

  final Experience exp;
  final bool isLast;

  @override
  State<TimelineExperienceCard> createState() => _TimelineExperienceCardState();
}

class _TimelineExperienceCardState extends State<TimelineExperienceCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final bool isMobileLarge = Responsive.isMobileLarge(context);
    final bool isSmallScreen = isMobile || isMobileLarge;

    // On mobile: smaller icon, less spacing to give more room for content
    final double iconSize = isSmallScreen ? 36 : 48;
    final double horizontalGap = isSmallScreen ? 12 : 24;
    final double cardPadding = isSmallScreen ? 14 : 20;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left column: Timeline Indicator node and connecting vertical path line
          Column(
            children: [
              // Company icon node or fallback briefcase icon
              Container(
                width: iconSize,
                height: iconSize,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E22),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isHovered ? primaryColor : borderColor,
                    width: 1.5,
                  ),
                ),
                padding: const EdgeInsets.all(6),
                child: ClipOval(
                  child: widget.exp.icon is Container
                      ? Icon(
                          Icons.work_outline,
                          color: primaryColor,
                          size: isSmallScreen ? 16 : 20,
                        )
                      : widget.exp.icon,
                ),
              ),
              // Vertical connecting timeline line
              if (!widget.isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: borderColor,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
            ],
          ),
          SizedBox(width: horizontalGap),
          // Right column: Detailed card with job description and information
          Expanded(
            child: MouseRegion(
              onEnter: (_) => setState(() => isHovered = true),
              onExit: (_) => setState(() => isHovered = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(bottom: 24),
                padding: EdgeInsets.all(cardPadding),
                decoration: BoxDecoration(
                  color: isHovered
                      ? const Color(0xFF2B2B2E) // Hover highlight charcoal color
                      : const Color(0xFF1E1E22), // Standard card color
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isHovered ? primaryColor : borderColor,
                    width: 1,
                  ),
                  boxShadow: isHovered
                      ? [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // On mobile: Stack title above duration to prevent squeezing
                    if (isSmallScreen) ...[
                      // Duration badge on top
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: primaryColor.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          widget.exp.duration,
                          style: const TextStyle(
                            color: primaryColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Full-width title
                      Text(
                        widget.exp.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                      ),
                    ] else ...[
                      // Desktop: title and duration side by side
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              widget.exp.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            widget.exp.duration,
                            style: const TextStyle(
                              color: primaryColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 6),
                    // Subtitle containing: Company, Location, Type
                    Text(
                      "${widget.exp.company.isNotEmpty ? '${widget.exp.company} · ' : ''}${widget.exp.location}${widget.exp.type.isNotEmpty ? ' · ${widget.exp.type}' : ''}",
                      style: TextStyle(
                        color: bodyTextColor,
                        fontSize: isSmallScreen ? 12 : 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // List of Skill Chips tags
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: widget.exp.skills
                          .map((skill) => Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isSmallScreen ? 8 : 10,
                                  vertical: isSmallScreen ? 4 : 5,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2B2B2C),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  skill,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: isSmallScreen ? 11 : 12,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
