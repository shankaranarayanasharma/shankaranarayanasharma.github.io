import 'package:flutter/material.dart';
import 'package:flutter_profile/screens/experience/exp.dart';
import 'package:flutter_profile/screens/home/footer.dart';
import 'package:flutter_profile/screens/main/main_screen.dart';
import 'package:flutter_profile/screens/projects/projects.dart';

import 'components/home_banner.dart';
import 'components/recommendations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScreen(
      children: const [
        HomeBanner(),
        ProjectScreen(),
        ExperienceScreen(),
        Recommendations(),
        DS8Footer(),
      ],
    );
  }
}
