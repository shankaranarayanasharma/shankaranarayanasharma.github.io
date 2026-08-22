import 'package:flutter/material.dart';
import 'package:flutter_profile/constants.dart';

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
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left column: Timeline Indicator node and connecting vertical path line
          Column(
            children: [
              // Company icon node or fallback briefcase icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E22),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isHovered ? primaryColor : borderColor,
                    width: 1.5,
                  ),
                ),
                padding: const EdgeInsets.all(8),
                child: ClipOval(
                  child: widget.exp.icon is Container
                      ? const Icon(
                          Icons.work_outline,
                          color: primaryColor,
                          size: 20,
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
          const SizedBox(width: 24),
          // Right column: Detailed card with job description and information
          Expanded(
            child: MouseRegion(
              onEnter: (_) => setState(() => isHovered = true),
              onExit: (_) => setState(() => isHovered = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(bottom: 24),
                padding: const EdgeInsets.all(20),
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
                    // Job Title and Duration Row
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
                    const SizedBox(height: 6),
                    // Subtitle containing: Company, Location, Type
                    Text(
                      "${widget.exp.company.isNotEmpty ? '${widget.exp.company} · ' : ''}${widget.exp.location}${widget.exp.type.isNotEmpty ? ' · ${widget.exp.type}' : ''}",
                      style: const TextStyle(
                        color: bodyTextColor,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // List of Skill Chips tags
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: widget.exp.skills
                          .map((skill) => Chip(
                                backgroundColor: const Color(0xFF2B2B2C),
                                side: BorderSide.none,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                label: Text(
                                  skill,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
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
