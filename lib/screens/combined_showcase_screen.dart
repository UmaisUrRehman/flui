import 'package:flutter/material.dart';
import '../widgets/code_snippet_view.dart';
import '../widgets/interactive_header.dart';

class CombinedShowcaseScreen extends StatefulWidget {
  const CombinedShowcaseScreen({super.key});

  @override
  State<CombinedShowcaseScreen> createState() => _CombinedShowcaseScreenState();
}

class _CombinedShowcaseScreenState extends State<CombinedShowcaseScreen> {
  String? _highlightedWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Combined Real-World Showcase'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const InteractiveHeader(
              title: 'Real-World Layout Composition',
              category: 'Combined Foundation Mastery',
              description: 'See how Container, Row, Column, Stack, Expanded, Flexible, and SizedBox combine to construct modern Flutter screens.',
              icon: Icons.dashboard_customize_rounded,
              color: Color(0xFF6366F1),
            ),
            const SizedBox(height: 20),

            // Inspector Selector Chips
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.saved_search_rounded, color: Colors.indigo),
                        SizedBox(width: 8),
                        Text(
                          'Interactive Widget Inspector',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Tap any widget tag below to highlight its exact position in the UI card below:',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildFilterChip('Container', Colors.blue),
                        _buildFilterChip('Row', Colors.green),
                        _buildFilterChip('Column', Colors.orange),
                        _buildFilterChip('Stack', Colors.purple),
                        _buildFilterChip('Expanded', Colors.pink),
                        _buildFilterChip('Flexible', Colors.cyan),
                        _buildFilterChip('SizedBox', Colors.indigo),
                        if (_highlightedWidget != null)
                          ActionChip(
                            avatar: const Icon(Icons.clear, size: 14),
                            label: const Text('Clear Filter'),
                            onPressed: () => setState(() => _highlightedWidget = null),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Real World Profile & Course Card Showcase
            _buildInspectedWrapper(
              widgetName: 'Container',
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Card Top Header Image Stack
                    _buildInspectedWrapper(
                      widgetName: 'Stack',
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          _buildInspectedWrapper(
                            widgetName: 'Container',
                            child: Container(
                              height: 140,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                gradient: LinearGradient(
                                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                            ),
                          ),

                          // Badge overlay top right
                          Positioned(
                            top: 14,
                            right: 14,
                            child: _buildInspectedWrapper(
                              widgetName: 'Container',
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.4),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: _buildInspectedWrapper(
                                  widgetName: 'Row',
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                                      _buildInspectedWrapper(
                                        widgetName: 'SizedBox',
                                        child: const SizedBox(width: 4),
                                      ),
                                      const Text(
                                        '4.9 (1.2k reviews)',
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Profile Avatar overlay
                          Positioned(
                            bottom: -30,
                            left: 20,
                            child: _buildInspectedWrapper(
                              widgetName: 'Stack',
                              child: Stack(
                                children: [
                                  Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.indigo.shade700,
                                      border: Border.all(color: Colors.white, width: 3),
                                    ),
                                    child: const Icon(Icons.person_rounded, color: Colors.white, size: 40),
                                  ),
                                  Positioned(
                                    bottom: 2,
                                    right: 2,
                                    child: Container(
                                      width: 18,
                                      height: 18,
                                      decoration: BoxDecoration(
                                        color: Colors.greenAccent.shade700,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.white, width: 2),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Card Body Details
                    _buildInspectedWrapper(
                      widgetName: 'Padding',
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 42, 20, 20),
                        child: _buildInspectedWrapper(
                          widgetName: 'Column',
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildInspectedWrapper(
                                widgetName: 'Row',
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildInspectedWrapper(
                                      widgetName: 'Expanded',
                                      child: Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              'Alex Morgan',
                                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Senior Flutter Architect',
                                              style: TextStyle(color: Colors.grey, fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    _buildInspectedWrapper(
                                      widgetName: 'Container',
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.indigo.shade50,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: const Text(
                                          'VERIFIED',
                                          style: TextStyle(color: Colors.indigo, fontSize: 10, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              _buildInspectedWrapper(
                                widgetName: 'SizedBox',
                                child: const SizedBox(height: 16),
                              ),

                              // Course statistics row
                              _buildInspectedWrapper(
                                widgetName: 'Container',
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade50,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: _buildInspectedWrapper(
                                    widgetName: 'Row',
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        _buildInspectedWrapper(
                                          widgetName: 'Flexible',
                                          child: Flexible(
                                            child: _buildStatItem('Courses', '24'),
                                          ),
                                        ),
                                        _buildInspectedWrapper(
                                          widgetName: 'SizedBox',
                                          child: const SizedBox(
                                            height: 24,
                                            child: VerticalDivider(thickness: 1, color: Colors.grey),
                                          ),
                                        ),
                                        _buildInspectedWrapper(
                                          widgetName: 'Flexible',
                                          child: Flexible(
                                            child: _buildStatItem('Students', '18.4k'),
                                          ),
                                        ),
                                        _buildInspectedWrapper(
                                          widgetName: 'SizedBox',
                                          child: const SizedBox(
                                            height: 24,
                                            child: VerticalDivider(thickness: 1, color: Colors.grey),
                                          ),
                                        ),
                                        _buildInspectedWrapper(
                                          widgetName: 'Flexible',
                                          child: Flexible(
                                            child: _buildStatItem('Experience', '6 Yrs'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              _buildInspectedWrapper(
                                widgetName: 'SizedBox',
                                child: const SizedBox(height: 16),
                              ),

                              // Action Buttons Row with Expanded
                              _buildInspectedWrapper(
                                widgetName: 'Row',
                                child: Row(
                                  children: [
                                    _buildInspectedWrapper(
                                      widgetName: 'Expanded',
                                      child: Expanded(
                                        child: ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFF6366F1),
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(vertical: 12),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                          ),
                                          onPressed: () {},
                                          icon: const Icon(Icons.person_add_rounded, size: 18),
                                          label: const Text('Follow Instructor'),
                                        ),
                                      ),
                                    ),
                                    _buildInspectedWrapper(
                                      widgetName: 'SizedBox',
                                      child: const SizedBox(width: 10),
                                    ),
                                    _buildInspectedWrapper(
                                      widgetName: 'Container',
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.bookmark_outline_rounded, color: Colors.black87),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Code structure summary
            CodeSnippetView(
              code: _generateStructureCode(),
              title: 'UI Hierarchy Architecture',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, Color color) {
    final isSelected = _highlightedWidget == label;
    return FilterChip(
      selected: isSelected,
      label: Text(label),
      selectedColor: color.withValues(alpha: 0.25),
      checkmarkColor: color,
      labelStyle: TextStyle(
        color: isSelected ? color : Colors.black87,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      onSelected: (selected) {
        setState(() {
          _highlightedWidget = selected ? label : null;
        });
      },
    );
  }

  Widget _buildInspectedWrapper({required String widgetName, required Widget child}) {
    final isHighlighted = _highlightedWidget == widgetName;
    if (!isHighlighted) return child;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red, width: 3),
        color: Colors.red.withValues(alpha: 0.12),
      ),
      child: child,
    );
  }

  Widget _buildStatItem(String label, String count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(count, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11)),
      ],
    );
  }

  String _generateStructureCode() {
    return '''// Real-World UI Card built with Foundation Widgets
Container( // Outer Card Container
  child: Column(
    children: [
      Stack( // Header Banner & Badges Stack
        children: [
          Container(height: 140, decoration: Gradient),
          Positioned(top: 14, right: 14, child: Container(child: Row(...))),
          Positioned(bottom: -30, left: 20, child: Stack(/* Avatar + Online Dot */)),
        ],
      ),
      Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row( // Title & Badge
              children: [
                Expanded(child: Column(/* Name & Role */)),
                Container(/* Verified Chip */),
              ],
            ),
            SizedBox(height: 16),
            Container( // Stats Container
              child: Row(
                children: [
                  Flexible(child: Column(/* Courses count */)),
                  SizedBox(height: 24, child: VerticalDivider()),
                  Flexible(child: Column(/* Students count */)),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row( // Action Buttons
              children: [
                Expanded(child: ElevatedButton(/* Follow */)),
                SizedBox(width: 10),
                Container(child: IconButton(/* Bookmark */)),
              ],
            ),
          ],
        ),
      ),
    ],
  ),
);''';
  }
}
