import 'package:flutter/material.dart';
import 'package:flutter_profile/responsive.dart';
import '../../../constants.dart';

class HighLightsInfo extends StatefulWidget {
  const HighLightsInfo({
    Key? key,
  }) : super(key: key);

  @override
  State<HighLightsInfo> createState() => _HighLightsInfoState();
}

class _HighLightsInfoState extends State<HighLightsInfo> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    // List of stat items defined in the reference mockup
    final items = [
      _buildStatItem(
        valueWidget: const AnimatedStatNumber(value: 13, suffix: "+"),
        label: "YEARS",
      ),
      _buildStatItem(
        valueWidget: const AnimatedStatNumber(value: 15, suffix: "+"),
        label: "PROJECTS",
      ),
      _buildStatItem(
        valueWidget: const Text(
          "∞",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        label: "CURIOSITY",
      ),
      _buildStatItem(
        valueWidget: const Text(
          "↑",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        label: "ALWAYS LEARNING",
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding),
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
          decoration: BoxDecoration(
            color: isHovered
                ? const Color(0xFF2B2B2E) // Hover highlight charcoal color
                : const Color(0xFF1E1E22), // Normal card color
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isHovered ? primaryColor : borderColor, // Glow gold on hover
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
          child: isMobile
              ? Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: items[0]),
                        Expanded(child: items[1]),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(child: items[2]),
                        Expanded(child: items[3]),
                      ],
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: items.map((item) => Expanded(child: item)).toList(),
                ),
        ),
      ),
    );
  }

  Widget _buildStatItem({required Widget valueWidget, required String label}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        valueWidget,
        const SizedBox(height: 10),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }
}

class AnimatedStatNumber extends StatelessWidget {
  const AnimatedStatNumber({
    Key? key,
    required this.value,
    required this.suffix,
  }) : super(key: key);

  final int value;
  final String suffix;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: IntTween(begin: 0, end: value),
      duration: const Duration(milliseconds: 1200),
      builder: (context, value, child) => Text(
        "$value$suffix",
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
