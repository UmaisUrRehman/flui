import 'package:flutter/material.dart';

class WidgetTopic {
  final String id;
  final String name;
  final String category;
  final String shortDescription;
  final String fullDescription;
  final IconData icon;
  final Color color;
  final List<String> keyFeatures;
  final String codeTemplate;
  final String bestUseCases;

  const WidgetTopic({
    required this.id,
    required this.name,
    required this.category,
    required this.shortDescription,
    required this.fullDescription,
    required this.icon,
    required this.color,
    required this.keyFeatures,
    required this.codeTemplate,
    required this.bestUseCases,
  });
}
