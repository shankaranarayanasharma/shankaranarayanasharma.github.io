import 'package:flutter/material.dart';
import 'package:flutter_profile/constants.dart';
import 'package:flutter_profile/responsive.dart';
import 'package:flutter_profile/screens/experience/exp_model.dart';
import 'package:flutter_profile/screens/experience/exp_widget.dart';
import 'package:flutter_profile/screens/projects/project_widget.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({Key? key}) : super(key: key);

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
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
                  Text(
                    "My Projects",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "These are the places where my technical career unfolded.",
                    style: TextStyle(
                      color: Color.fromRGBO(163, 163, 163, 1.0),
                      fontSize:
                          Theme.of(context).textTheme.bodyMedium!.fontSize,
                      fontWeight:
                          Theme.of(context).textTheme.bodyMedium!.fontWeight,
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
                    padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding * 2,
                        vertical: defaultPadding),
                    backgroundColor: Colors.transparent),
                child: Text(
                  "View All ->",
                  style: TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
        const SizedBox(height: defaultPadding),
        Responsive(
          mobile: ProjectGridView(
            crossAxisCount: 1,
            childAspectRatio: 1.7,
          ),
          mobileLarge: ProjectGridView(crossAxisCount: 2),
          tablet: ProjectGridView(childAspectRatio: 1.1),
          desktop: ProjectGridView(staticCount: showAll ? 3 : null,),
        )
      ],
    );
  }
}
