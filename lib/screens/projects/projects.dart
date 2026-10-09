import 'package:flutter/material.dart';
import 'package:flutter_profile/constants.dart';
import 'package:flutter_profile/responsive.dart';
import 'package:flutter_profile/screens/projects/components/project_grid_view.dart';
import 'package:flutter_profile/viewmodels/projects_viewmodel.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({Key? key}) : super(key: key);

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  final ProjectsViewModel _viewModel = ProjectsViewModel();

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _viewModel,
      builder: (context, _) {
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
                        AppStrings.myProjects,
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
                    onPressed: _viewModel.toggleShowAll,
                    style: TextButton.styleFrom(
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding * 2,
                            vertical: defaultPadding),
                        backgroundColor: Colors.transparent),
                    child: Text(
                      _viewModel.showAll ? "View All ->" : "View Less <-",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            ),
            // On mobile: show the toggle button below the header, full-width
            if (Responsive.isMobileLarge(context)) ...
              [
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: _viewModel.toggleShowAll,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: primaryColor, width: 1),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      _viewModel.showAll ? "View All →" : "View Less ←",
                      style: const TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            const SizedBox(height: defaultPadding),
            LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                int crossCount = 2;
                double aspect = 0.9;

                if (width > 1050) {
                  crossCount = 4;
                  aspect = 0.82;
                } else if (width > 750) {
                  crossCount = 3;
                  aspect = 0.85;
                } else if (width > 500) {
                  crossCount = 2;
                  aspect = 0.9;
                } else {
                  crossCount = 1;
                  aspect = 1.05;
                }

                return ProjectGridView(
                  projects: _viewModel.projects,
                  crossAxisCount: crossCount,
                  childAspectRatio: aspect,
                  staticCount: _viewModel.staticCount,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
