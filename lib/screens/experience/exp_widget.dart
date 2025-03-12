import 'package:flutter/material.dart';
import 'package:flutter_profile/constants.dart';
import 'package:flutter_profile/screens/experience/exp_model.dart';

class ExperienceCard extends StatelessWidget {
  const ExperienceCard({
    Key? key,
    required this.exp,
  }) : super(key: key);

  final Experience exp;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF242430),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.withOpacity(0.5))),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child:exp.icon,
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          exp.title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(exp.company,
                      style: const TextStyle(color: Colors.grey, fontSize: 16)),
                  Text("${exp.duration} · ${exp.type}",
                      style: const TextStyle(color: Colors.grey, fontSize: 14)),
                  Text(exp.location,
                      style: const TextStyle(color: Colors.grey, fontSize: 14)),
                  const SizedBox(height: 10),
                  Divider(),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: exp.skills
                        .map((skill) => Chip(
                          backgroundColor: Color(0xFF242430)  ,
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
            ),
          ],
        ),
      ),
    );
  }
}

class ExperienceGridView extends StatelessWidget {
  const ExperienceGridView({
    Key? key,
    this.crossAxisCount = 2,
    this.childAspectRatio = 2,
    this.staticCount,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;
  final int? staticCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: staticCount ?? experiences.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
      ),
      itemBuilder: (context, index) => ExperienceCard(
        exp: experiences[index],
      ),
    );
  }
}
