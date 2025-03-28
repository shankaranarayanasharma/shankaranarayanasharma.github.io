import 'package:flutter/material.dart';
import 'package:flutter_profile/constants.dart';
import 'package:flutter_profile/screens/experience/exp.dart';
import 'package:flutter_profile/screens/home/footer.dart';
import 'package:flutter_profile/screens/main/main_screen.dart';
import 'package:flutter_profile/screens/projects/projects.dart';

import 'components/heighlights.dart';
import 'components/home_banner.dart';
import 'components/my_projects.dart';
import 'components/recommendations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScreen(
      children: [
        HomeBanner(),
        ExperienceScreen(),
        ProjectScreen(),
        SizedBox(width: defaultPadding),
        Recommendations(),
        DS8Footer(),
      ],
    );
  }
}
