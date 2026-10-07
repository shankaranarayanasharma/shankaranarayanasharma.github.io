import 'package:flutter/material.dart';

/// Helper to setup and manage animation intervals for the 8 loader steps
class LoaderAnimationController {
  final AnimationController controller;

  late final Animation<double> glowAnim;
  late final Animation<double> nameAnim;
  late final Animation<double> roleAnim;
  late final Animation<double> taglineAnim;
  late final Animation<double> techAnim;
  late final Animation<double> contactAnim;
  late final Animation<double> progressAnim;
  late final Animation<double> photoAnim;

  LoaderAnimationController({required this.controller}) {
    // Step 1: Start Background Glow
    glowAnim = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.00, 0.40, curve: Curves.easeOut),
    );

    // Step 2: Name Typing (0.10 -> 0.35)
    nameAnim = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.10, 0.35, curve: Curves.linear),
    );

    // Step 3: Role Appear (0.30 -> 0.50)
    roleAnim = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.30, 0.50, curve: Curves.easeOut),
    );

    // Step 4: Tagline Fade In (0.45 -> 0.65)
    taglineAnim = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.45, 0.65, curve: Curves.easeOut),
    );

    // Step 5: Tech Stack Pop In (0.55 -> 0.75)
    techAnim = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.55, 0.75, curve: Curves.easeOut),
    );

    // Step 6: Contact Info Appear (0.65 -> 0.82)
    contactAnim = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.65, 0.82, curve: Curves.easeOut),
    );

    // Step 7: Loading Progress (0.05 -> 0.92)
    progressAnim = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.05, 0.92, curve: Curves.easeInOut),
    );

    // Step 8: Photo & Glow Reveal (0.72 -> 1.00)
    photoAnim = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.72, 1.00, curve: Curves.easeOutCubic),
    );
  }
}
