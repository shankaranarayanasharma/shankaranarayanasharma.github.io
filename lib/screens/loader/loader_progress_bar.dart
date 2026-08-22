import 'package:flutter/material.dart';

/// Step 5: Progress Bar & Footer Motto scaled to fit custom card width
class LoaderProgressBar extends StatelessWidget {
  final Animation<double> progressAnimation;

  const LoaderProgressBar({
    Key? key,
    required this.progressAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 1024;
    final isTablet = width > 600 && width <= 1024;

    final double titleFontSize = isDesktop ? 12 : (isTablet ? 11 : 10);
    final double barWidth = isDesktop ? 280 : (isTablet ? 230 : width * 0.45);
    final double barHeight = isDesktop ? 14 : (isTablet ? 12 : 11);
    final double percentFontSize = isDesktop ? 12 : (isTablet ? 11 : 10);

    return AnimatedBuilder(
      animation: progressAnimation,
      builder: (context, child) {
        final val = progressAnimation.value.clamp(0.0, 1.0);
        final percentage = (val * 100).toInt();

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Loading My Portfolio...",
              style: TextStyle(
                fontSize: titleFontSize,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
            SizedBox(height: isDesktop ? 5 : 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: barWidth,
                  height: barHeight,
                  child: Container(
                    padding: const EdgeInsets.all(1.8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF040A14),
                      borderRadius: BorderRadius.circular(barHeight / 2),
                      border: Border.all(
                        color: const Color(0xFF007AFF).withValues(alpha: 0.75),
                        width: 1.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF007AFF).withValues(alpha: 0.18),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        FractionallySizedBox(
                          widthFactor: val.clamp(0.02, 1.0),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF0044BB),
                                  Color(0xFF007AFF),
                                  Color(0xFF38BDF8),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(barHeight / 2),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF38BDF8)
                                      .withValues(alpha: 0.85),
                                  blurRadius: 6,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: isDesktop ? 8 : 6),
                Text(
                  "$percentage%",
                  style: TextStyle(
                    fontSize: percentFontSize,
                    color: const Color(0xFF38BDF8),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
            SizedBox(height: isDesktop ? 6 : 4),
            Text(
              "C O D E   •   B U I L D   •   I N N O V A T E",
              style: TextStyle(
                fontSize: isDesktop ? 8.5 : 7.5,
                fontWeight: FontWeight.w600,
                color: Colors.white38,
                letterSpacing: isDesktop ? 3.5 : 2.0,
              ),
            ),
          ],
        );
      },
    );
  }
}
