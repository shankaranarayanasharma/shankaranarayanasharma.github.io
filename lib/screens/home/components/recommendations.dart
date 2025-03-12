import 'package:flutter/material.dart';
import 'package:flutter_profile/models/Recommendation.dart';
import 'package:flutter_profile/screens/home/components/recommendation_card.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class Recommendations extends StatelessWidget {
  const Recommendations({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Tools & Technologies",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          Text(
            "I love using so many tools to make my work easier. Here are some of them.",
            style: TextStyle(
              color: Color.fromRGBO(163, 163, 163, 1.0),
              fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
              fontWeight: Theme.of(context).textTheme.bodyMedium!.fontWeight,
            ),
          ),
          const SizedBox(height: defaultPadding),
          Text(
            "Frontend & Backend Development",
            style: TextStyle(
              color: Colors.white,
              fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: defaultPadding),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: ["firebase", "flutter", "swift", "objective-c"]
                .map((skill) => Chip(
                      avatar: SvgPicture.asset(
                        "assets/images/$skill.svg",
                        semanticsLabel: 'Dart Logo',
                      ),
                      backgroundColor: Color(0xFF242430),
                      side: BorderSide.none,
                      label: Text(
                        skill,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
