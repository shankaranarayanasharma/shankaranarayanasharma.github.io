import 'package:flutter/material.dart';

/// Step 6: Responsive Profile Photo Cutout matching attached image look & feel
class LoaderProfilePhoto extends StatelessWidget {
  final Animation<double> animation;

  const LoaderProfilePhoto({
    Key? key,
    required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 1024;
    final isTablet = width > 600 && width <= 1024;

    final double photoWidth = isDesktop ? 280 : (isTablet ? 230 : 180);
    final double photoHeight = isDesktop ? 340 : (isTablet ? 280 : 220);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final progress = animation.value.clamp(0.0, 1.0);
        final opacity = progress.clamp(0.0, 1.0);
        final scale = 0.92 + (progress * 0.08);

        return Transform.scale(
          scale: scale,
          alignment: Alignment.topRight,
          child: Opacity(
            opacity: opacity,
            child: Stack(
              alignment: Alignment.topRight,
              clipBehavior: Clip.none,
              children: [
                
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: SizedBox(
                    width: photoWidth,
                    height: photoHeight,
                    child: ShaderMask(
                      shaderCallback: (rect) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black,
                            Colors.black,
                            Colors.black45,
                            Colors.transparent,
                          ],
                          stops: [0.0, 0.42, 0.70, 1.0],
                        ).createShader(rect);
                      },
                      blendMode: BlendMode.dstIn,
                      child: Image.asset(
                        "assets/images/loader/logo.png",
                        fit: BoxFit.contain,
                        alignment: Alignment.topRight,
                        errorBuilder: (context, error, stackTrace) => Image.asset(
                          "assets/images/IMG_7344.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
