import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Step 7: Futuristic Orbital Background matching Section 2 specs
class LoaderBackground extends StatelessWidget {
  final Animation<double> glowAnimation;

  const LoaderBackground({
    Key? key,
    required this.glowAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: glowAnimation,
      builder: (context, child) {
        final val = glowAnimation.value.clamp(0.0, 1.0);

        return Stack(
          children: [
            // Dark Base
            Container(color: const Color(0xFF03050B)),

            // Ambient Central Radial Blue Illumination
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 0.95,
                    colors: [
                      const Color(0xFF0066FF).withValues(alpha: 0.28 * val),
                      const Color(0xFF38BDF8).withValues(alpha: 0.09 * val),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.55, 1.0],
                  ),
                ),
              ),
            ),

            // Large Concentric Orbit Circles & Dots
            Positioned.fill(
              child: CustomPaint(
                painter: _OrbitalPainter(progress: val),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _OrbitalPainter extends CustomPainter {
  final double progress;

  _OrbitalPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final ringPaint = Paint()
      ..color = const Color(0xFF007AFF).withValues(alpha: 0.16 * progress)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final dashRingPaint = Paint()
      ..color = const Color(0xFF38BDF8).withValues(alpha: 0.10 * progress)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final dotPaint = Paint()
      ..color = const Color(0xFF38BDF8).withValues(alpha: 0.75 * progress)
      ..style = PaintingStyle.fill;

    // 4 Large Concentric Orbit Circles extending beyond viewport
    final baseRadius = size.width * 0.24;
    final radii = [
      baseRadius,
      baseRadius * 1.6,
      baseRadius * 2.3,
      baseRadius * 3.1,
    ];

    for (int i = 0; i < radii.length; i++) {
      final r = radii[i];
      canvas.drawCircle(center, r, i % 2 == 0 ? ringPaint : dashRingPaint);
    }

    // Sparse Stable Glowing Particles
    final rand = math.Random(1337);
    for (int i = 0; i < 24; i++) {
      final angle = rand.nextDouble() * 2 * math.pi;
      final dist = (0.15 + rand.nextDouble() * 0.70) * size.width;
      final offset =
          center + Offset(math.cos(angle) * dist, math.sin(angle) * dist);
      final radius = 1.5 + rand.nextDouble() * 2.2;
      canvas.drawCircle(offset, radius, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _OrbitalPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
