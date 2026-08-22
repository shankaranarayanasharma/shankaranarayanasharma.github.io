import 'package:flutter/material.dart';
import 'package:flutter_profile/constants.dart';
import 'package:flutter_profile/responsive.dart';
import 'package:flutter_profile/screens/experience/exp_widget.dart';

class ExperienceScreen extends StatefulWidget {
  const ExperienceScreen({Key? key}) : super(key: key);

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  bool showAll = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Professional Journey",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "These are the places where my technical career unfolded.",
                    style: TextStyle(
                      color: const Color.fromRGBO(163, 163, 163, 1.0),
                      fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                      fontWeight: Theme.of(context).textTheme.bodyMedium!.fontWeight,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: defaultPadding),
            if (!Responsive.isMobileLarge(context))
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showAll = !showAll;
                  });
                },
                style: TextButton.styleFrom(
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding * 2,
                        vertical: defaultPadding),
                    backgroundColor: Colors.transparent),
                child: Text(
                  showAll ? "View Less <-" : "View All ->",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
        const SizedBox(height: defaultPadding),
        Column(
          children: List.generate(
            showAll ? PortfolioData.experiences.length : 2,
            (index) => TimelineExperienceCard(
              exp: PortfolioData.experiences[index],
              isLast: index == (showAll ? PortfolioData.experiences.length - 1 : 1),
            ),
          ),
        ),
      ],
    );
  }
}
