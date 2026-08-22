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
            const SizedBox(height: defaultPadding),
            Builder(
              builder: (context) {
                final width = MediaQuery.of(context).size.width;
                int crossCount = 2;
                double aspect = 1.1;

                if (width > 1400) {
                  crossCount = 4;
                  aspect = 0.98;
                } else if (width > 950) {
                  crossCount = 3;
                  aspect = 1.02;
                } else if (width > 600) {
                  crossCount = 2;
                  aspect = 1.1;
                } else {
                  crossCount = 1;
                  aspect = 1.15;
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
