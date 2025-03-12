// import 'package:flutter/material.dart';
// import 'package:flutter_profile/models/Project.dart';
// import 'package:flutter_profile/responsive.dart';
// import 'package:flutter_profile/screens/home/components/feature_project.dart';
// import 'package:scroll_to_index/scroll_to_index.dart';

// import '../../../constants.dart';
// import 'project_card.dart';

// class MyProjects extends StatefulWidget {
//   const MyProjects({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<MyProjects> createState() => _MyProjectsState();
// }

// class _MyProjectsState extends State<MyProjects> {
//   AutoScrollController? _autoScrollController;

//   final scrollDirection = Axis.vertical;

//   bool isExpaned = true;

//   bool get _isAppBarExpanded {
//     return _autoScrollController!.hasClients &&
//         _autoScrollController!.offset > (160 - kToolbarHeight);
//   }

//   @override
//   void initState() {
//     _autoScrollController = AutoScrollController(
//       viewportBoundaryGetter: () =>
//           Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
//       axis: scrollDirection,
//     )..addListener(
//         () => _isAppBarExpanded
//             ? isExpaned != false
//                 ? setState(
//                     () {
//                       isExpaned = false;
//                       print('setState is called');
//                     },
//                   )
//                 : {}
//             : isExpaned != true
//                 ? setState(() {
//                     print('setState is called');
//                     isExpaned = true;
//                   })
//                 : {},
//       );
//     super.initState();
//   }

//   Future _scrollToIndex(int index) async {
//     await _autoScrollController?.scrollToIndex(index,
//         preferPosition: AutoScrollPosition.begin);
//     _autoScrollController?.highlight(index);
//   }

//   Widget _wrapScrollTag({int index = -1, Widget? child}) {
//     return AutoScrollTag(
//       key: ValueKey(index),
//       controller: _autoScrollController!,
//       index: index,
//       child: child,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "My Projects",
//           style: Theme.of(context).textTheme.titleLarge,
//         ),
//         const SizedBox(height: defaultPadding),
//         _wrapScrollTag(
//           index: 2,
//           child: Column(children: [
//             FeatureProject(
//               imagePath: "assets/images/forager_mobil_mokup.jpg",
//               ontab: () {},
//               projectDesc:
//                   "A Mobile app for both Android and IOS. View your Status, Chat, and call history. The purpose of this projcet is to Learn Flutter complex UI Design.",
//               projectTitle: "WhatsaApp UI Clone",
//               tech1: "Flutter",
//               tech2: "Dart",
//               tech3: "Flutter UI",
//             ),
//           ]),
//         ),
//         // Responsive(
//         //   mobile: ProjectsGridView(
//         //     crossAxisCount: 1,
//         //     childAspectRatio: 1.7,
//         //   ),
//         //   mobileLarge: ProjectsGridView(crossAxisCount: 2),
//         //   tablet: ProjectsGridView(childAspectRatio: 1.1),
//         //   desktop: ProjectsGridView(),
//         // )
//       ],
//     );
//   }
// }

// class ProjectsGridView extends StatelessWidget {
//   const ProjectsGridView({
//     Key? key,
//     this.crossAxisCount = 3,
//     this.childAspectRatio = 1.3,
//   }) : super(key: key);

//   final int crossAxisCount;
//   final double childAspectRatio;

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemCount: demo_projects.length,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: crossAxisCount,
//         childAspectRatio: childAspectRatio,
//         crossAxisSpacing: defaultPadding,
//         mainAxisSpacing: defaultPadding,
//       ),
//       itemBuilder: (context, index) => ProjectCard(
//         project: demo_projects[index],
//       ),
//     );
//   }
// }
