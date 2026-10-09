import 'package:flutter/material.dart';
import '../data/widget_data.dart';
import '../widgets/code_snippet_view.dart';
import '../widgets/interactive_header.dart';

class StackPlayground extends StatefulWidget {
  const StackPlayground({super.key});

  @override
  State<StackPlayground> createState() => _StackPlaygroundState();
}

class _StackPlaygroundState extends State<StackPlayground> {
  Alignment _stackAlignment = Alignment.topRight;
  StackFit _stackFit = StackFit.loose;

  // Positioned widget 1 controls
  double _top = 16;
  double _left = 16;

  // Positioned widget 2 controls
  double _bottom = 16;
  double _right = 16;

  int _presetIndex = 0;

  final Map<String, Alignment> _alignmentMap = {
    'topRight': Alignment.topRight,
    'topLeft': Alignment.topLeft,
    'center': Alignment.center,
    'bottomCenter': Alignment.bottomCenter,
    'bottomRight': Alignment.bottomRight,
  };

  @override
  Widget build(BuildContext context) {
    final topic = WidgetData.coreWidgets.firstWhere((w) => w.id == 'stack');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stack & Positioned Playground'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InteractiveHeader(
              title: topic.name,
              category: topic.category,
              description: topic.shortDescription,
              icon: topic.icon,
              color: topic.color,
            ),
            const SizedBox(height: 20),

            // Demo Mode Presets
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text('Interactive Canvas')),
                ButtonSegment(value: 1, label: Text('Avatar Badge')),
                ButtonSegment(value: 2, label: Text('Card Overlay')),
              ],
              selected: {_presetIndex},
              onSelectionChanged: (val) {
                setState(() => _presetIndex = val.first);
              },
            ),
            const SizedBox(height: 20),

            // Visual Canvas
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Layered Stack Canvas',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      height: 280,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade50,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: _buildStackCanvas(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Controls (shown for Interactive mode)
            if (_presetIndex == 0) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Stack & Positioned Offsets',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),

                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<Alignment>(
                              value: _stackAlignment,
                              decoration: const InputDecoration(
                                labelText: 'Default Stack Alignment',
                                border: OutlineInputBorder(),
                              ),
                              items: _alignmentMap.entries.map((e) {
                                return DropdownMenuItem(value: e.value, child: Text('Alignment.${e.key}'));
                              }).toList(),
                              onChanged: (val) {
                                if (val != null) setState(() => _stackAlignment = val);
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: DropdownButtonFormField<StackFit>(
                              value: _stackFit,
                              decoration: const InputDecoration(
                                labelText: 'StackFit',
                                border: OutlineInputBorder(),
                              ),
                              items: const [
                                DropdownMenuItem(value: StackFit.loose, child: Text('StackFit.loose')),
                                DropdownMenuItem(value: StackFit.expand, child: Text('StackFit.expand')),
                              ],
                              onChanged: (val) {
                                if (val != null) setState(() => _stackFit = val);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      const Text('Layer 2 (Positioned Top & Left):', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)),
                      _buildSliderRow('Top', _top, 0, 180, (v) => setState(() => _top = v)),
                      _buildSliderRow('Left', _left, 0, 180, (v) => setState(() => _left = v)),

                      const Divider(height: 24),
                      const Text('Layer 3 (Positioned Bottom & Right):', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple)),
                      _buildSliderRow('Bottom', _bottom, 0, 180, (v) => setState(() => _bottom = v)),
                      _buildSliderRow('Right', _right, 0, 180, (v) => setState(() => _right = v)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],

            // Generated Code
            CodeSnippetView(
              code: _generateCodeSnippet(),
              title: 'Stack Code Snippet',
            ),
            const SizedBox(height: 20),

            _buildConceptCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildStackCanvas() {
    if (_presetIndex == 1) {
      // Avatar badge example
      return Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(colors: [Colors.purple, Colors.indigo]),
                boxShadow: [
                  BoxShadow(color: Colors.purple.withValues(alpha: 0.4), blurRadius: 12, offset: const Offset(0, 4)),
                ],
              ),
              child: const Icon(Icons.person_rounded, color: Colors.white, size: 60),
            ),
            Positioned(
              bottom: 4,
              right: 4,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
              ),
            ),
            Positioned(
              top: -6,
              right: -6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Text(
                  'NEW',
                  style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (_presetIndex == 2) {
      // Card overlay example
      return Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Icon(Icons.landscape_rounded, size: 100, color: Colors.white24),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: const [
                  Icon(Icons.star, size: 14, color: Colors.black),
                  SizedBox(width: 4),
                  Text('FEATURED COURSE', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 11)),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black.withValues(alpha: 0.85)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Flutter UI Mastery 2026',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Master layout constraints, Stack positioning, and custom painting.',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    // Default Interactive Mode
    return Stack(
      alignment: _stackAlignment,
      fit: _stackFit,
      children: [
        // Layer 1: Base Background Container
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.indigo.shade50,
          alignment: Alignment.center,
          child: Text(
            'Base Stack Layer 1\n(Alignment: ${_stackAlignment.toString().split('.').last})',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.indigo.shade300, fontWeight: FontWeight.bold),
          ),
        ),

        // Layer 2: Positioned Top Left
        Positioned(
          top: _top,
          left: _left,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))],
            ),
            child: Text(
              'Layer 2 (T: ${_top.toInt()}, L: ${_left.toInt()})',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
        ),

        // Layer 3: Positioned Bottom Right
        Positioned(
          bottom: _bottom,
          right: _right,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))],
            ),
            child: Text(
              'Layer 3 (B: ${_bottom.toInt()}, R: ${_right.toInt()})',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSliderRow(String label, double value, double min, double max, ValueChanged<double> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text('$label: ${value.toStringAsFixed(0)}px', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          ),
          Expanded(
            child: Slider(
              value: value,
              min: min,
              max: max,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  String _generateCodeSnippet() {
    if (_presetIndex == 1) {
      return '''Stack(
  clipBehavior: Clip.none,
  children: [
    Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.indigo),
      child: Icon(Icons.person, color: Colors.white),
    ),
    Positioned(
      bottom: 4,
      right: 4,
      child: Container(width: 24, height: 24, color: Colors.green),
    ),
    Positioned(
      top: -6,
      right: -6,
      child: Container(color: Colors.red, child: Text("NEW")),
    ),
  ],
)''';
    }

    return '''Stack(
  alignment: Alignment.${_stackAlignment.toString().split('.').last},
  fit: StackFit.${_stackFit.name},
  children: [
    // Base Layer
    Container(color: Colors.indigo.shade50),
    // Positioned Layer Top/Left
    Positioned(
      top: ${_top.toStringAsFixed(0)}.0,
      left: ${_left.toStringAsFixed(0)}.0,
      child: Container(color: Colors.indigo, child: Text("Layer 2")),
    ),
    // Positioned Layer Bottom/Right
    Positioned(
      bottom: ${_bottom.toStringAsFixed(0)}.0,
      right: ${_right.toStringAsFixed(0)}.0,
      child: Container(color: Colors.purple, child: Text("Layer 3")),
    ),
  ],
)''';
  }

  Widget _buildConceptCard() {
    return Card(
      color: Colors.purple.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.purple.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Row(
              children: [
                Icon(Icons.layers_rounded, color: Colors.purple),
                SizedBox(width: 8),
                Text(
                  'Stack Layout Rules',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.purple),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text('• Z-Index Rendering: Children are drawn in list order. First child is bottom-most layer.'),
            SizedBox(height: 4),
            Text('• Non-Positioned Children: Positioned according to Stack\'s alignment property.'),
            SizedBox(height: 4),
            Text('• Positioned Widget: Gives child absolute offsets from top, bottom, left, or right edge.'),
            SizedBox(height: 4),
            Text('• clipBehavior: Set Clip.none to let child badges extend outside stack bounds.'),
          ],
        ),
      ),
    );
  }
}
