import 'package:flutter/material.dart';
import 'package:flutter_profile/constants.dart';
import 'package:flutter_profile/models/Project.dart';
import 'package:flutter_profile/screens/experience/exp_model.dart';
import 'package:flutter_profile/screens/projects/project_model.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel blog;
  const ProjectCard({
    Key? key,
    required this.blog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                blog.image,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8, // Space between categories
                    children: blog.categories.map((category) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          category,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    blog.title,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  if (blog.description != null)
                    Column(
                      children: [
                        SizedBox(
                          width: double
                              .infinity, // Ensures the text takes the available width
                          child: Text(
                            blog.description ?? "",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white60,
                              overflow: TextOverflow
                                  .ellipsis, // Use ellipsis for trimming long text
                            ),
                            maxLines:
                                2, // Set the max number of lines before trimming
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  Row(
                    children: [
                      Text(
                        blog.author,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 6),
                      const Icon(Icons.circle, size: 4, color: Colors.red),
                      const SizedBox(width: 6),
                      Text(
                        blog.date,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
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

class BottomRightInwardCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width - 80, size.height);
    path.quadraticBezierTo(
        size.width - 60, size.height - 80, size.width, size.height - 60);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class ProjectGridView extends StatelessWidget {
  const ProjectGridView({
    Key? key,
    this.crossAxisCount = 3,
    this.childAspectRatio = 0.85,
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
      itemCount: staticCount ?? blogPosts.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
      ),
      itemBuilder: (context, index) => ProjectCard(
        blog: blogPosts[index],
      ),
    );
  }
}
