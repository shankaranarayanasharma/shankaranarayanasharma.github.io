import 'package:flutter/material.dart';
import 'package:flutter_profile/data/portfolio_data.dart';
import 'package:flutter_profile/models/Project.dart';
import 'package:flutter_profile/screens/project_detail/project_detail_overlay.dart';
import 'package:flutter_profile/screens/project_detail/project_detail_page.dart';

class ProjectsViewModel extends ChangeNotifier {
  bool _showAll = true;

  bool get showAll => _showAll;

  void toggleShowAll() {
    _showAll = !_showAll;
    notifyListeners();
  }

  List<Project> get projects =>
      PortfolioData.projectsJson.map((json) => Project.fromJson(json)).toList();

  int? get staticCount => _showAll ? 4 : null;

  void openProject(BuildContext context, Project project) {
    final width = MediaQuery.of(context).size.width;

    if (width < 600) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProjectDetailsPage(project: project),
        ),
      );
    } else {
      showDialog(
        context: context,
        barrierColor: Colors.black54,
        builder: (_) => Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(32),
          child: ProjectDetailsOverlay(project: project),
        ),
      );
    }
  }
}
