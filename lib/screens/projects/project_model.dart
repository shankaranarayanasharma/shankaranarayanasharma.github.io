import 'package:flutter/material.dart';

class ProjectModel {
  final String title;
  final List<String> categories; // Change to List<String>
  final String author;
  final String date;
  final String image;
  final String? description;

  ProjectModel({
    required this.title,
    required this.categories,
    required this.author,
    required this.date,
    required this.image,
    this.description,
  });
}