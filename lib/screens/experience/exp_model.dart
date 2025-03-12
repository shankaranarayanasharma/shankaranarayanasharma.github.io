import 'package:flutter/material.dart';

class Experience {
  final String title;
  final String company;
  final String duration;
  final String location;
  final String type;
  final List<String> skills;
  final Widget icon;

  Experience({
    required this.title,
    required this.company,
    required this.duration,
    required this.location,
    required this.type,
    required this.skills,
    required this.icon,
  });
}