import 'package:flutter/material.dart';
import '../data/widget_data.dart';
import '../widgets/code_snippet_view.dart';
import '../widgets/interactive_header.dart';

class SizedBoxPlayground extends StatefulWidget {
  const SizedBoxPlayground({super.key});

  @override
  State<SizedBoxPlayground> createState() => _SizedBoxPlaygroundState();
}

class _SizedBoxPlaygroundState extends State<SizedBoxPlayground> {
  double _width = 150;
  double _height = 80;
  double _spacingGap = 20;
  int _modeIndex = 0; // 0: Fixed Size, 1: Spacing Helper, 2: SizedBox.expand

  @override
  Widget build(BuildContext context) {
    final topic = WidgetData.coreWidgets.firstWhere((w) => w.id == 'sizedbox');

    return Scaffold(
      appBar: AppBar(
        title: const Text('SizedBox Playground'),
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

            // Mode Selector
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text('Fixed Dimensions')),
                ButtonSegment(value: 1, label: Text('Spacing Helper')),
                ButtonSegment(value: 2, label: Text('SizedBox.expand')),
              ],
              selected: {_modeIndex},
              onSelectionChanged: (val) {
                setState(() => _modeIndex = val.first);
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
                    Text(
                      _modeIndex == 0
                          ? 'Fixed Dimension Box'
                          : _modeIndex == 1
                              ? 'Whitespace Spacing inside Column'
                              : 'SizedBox.expand() Filling Parent Constraints',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      height: 240,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Center(
                        child: _buildCanvasContent(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Controls
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SizedBox Property Controls',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    if (_modeIndex == 0) ...[
                      Row(
                        children: [
                          SizedBox(width: 90, child: Text('Width: ${_width.toInt()}px', style: const TextStyle(fontWeight: FontWeight.w500))),
                          Expanded(
                            child: Slider(
                              value: _width,
                              min: 50,
                              max: 280,
                              onChanged: (v) => setState(() => _width = v),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 90, child: Text('Height: ${_height.toInt()}px', style: const TextStyle(fontWeight: FontWeight.w500))),
                          Expanded(
                            child: Slider(
                              value: _height,
                              min: 30,
                              max: 180,
                              onChanged: (v) => setState(() => _height = v),
                            ),
                          ),
                        ],
                      ),
                    ] else if (_modeIndex == 1) ...[
                      Row(
                        children: [
                          SizedBox(width: 110, child: Text('Spacer Gap: ${_spacingGap.toInt()}px', style: const TextStyle(fontWeight: FontWeight.w500))),
                          Expanded(
                            child: Slider(
                              value: _spacingGap,
                              min: 0,
                              max: 60,
                              onChanged: (v) => setState(() => _spacingGap = v),
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      const Text(
                        'SizedBox.expand() forces child to take double.infinity width and height, completely filling parent bounds.',
                        style: TextStyle(fontSize: 13, color: Colors.black87),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Code Snippet
            CodeSnippetView(
              code: _generateCodeSnippet(),
              title: 'SizedBox Code Snippet',
            ),
            const SizedBox(height: 20),

            _buildConceptCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildCanvasContent() {
    if (_modeIndex == 1) {
      // Spacing helper mode
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: Colors.indigo,
            child: const Text('Header Widget', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: _spacingGap),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.amber.shade200,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '↑ SizedBox(height: ${_spacingGap.toInt()}) ↓',
              style: TextStyle(color: Colors.amber.shade900, fontWeight: FontWeight.bold, fontSize: 11),
            ),
          ),
          SizedBox(height: _spacingGap),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: Colors.teal,
            child: const Text('Footer Widget', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      );
    } else if (_modeIndex == 2) {
      // SizedBox.expand mode
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox.expand(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.indigo.shade600,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: const Text(
              'SizedBox.expand()\nFilled Parent Box completely',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      );
    }

    // Default Fixed size mode
    return SizedBox(
      width: _width,
      height: _height,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: () {},
        icon: const Icon(Icons.touch_app_rounded),
        label: Text('Size (${_width.toInt()}x${_height.toInt()})'),
      ),
    );
  }

  String _generateCodeSnippet() {
    if (_modeIndex == 1) {
      return '''Column(
  children: [
    Text("Header Widget"),
    SizedBox(height: ${_spacingGap.toInt()}.0), // Empty whitespace gap
    Text("Footer Widget"),
  ],
)''';
    } else if (_modeIndex == 2) {
      return '''SizedBox.expand(
  child: Container(
    color: Colors.indigo,
    child: Text("Fills all available parent constraints"),
  ),
)''';
    }

    return '''SizedBox(
  width: ${_width.toInt()}.0,
  height: ${_height.toInt()}.0,
  child: ElevatedButton(
    onPressed: () {},
    child: Text("Fixed Size Button"),
  ),
)''';
  }

  Widget _buildConceptCard() {
    return Card(
      color: Colors.indigo.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.indigo.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Row(
              children: [
                Icon(Icons.aspect_ratio_rounded, color: Colors.indigo),
                SizedBox(width: 8),
                Text(
                  'SizedBox Key Constructors',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.indigo),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text('• SizedBox(width: w, height: h): Enforces strict width & height on child.'),
            SizedBox(height: 4),
            Text('• SizedBox(height: 16): Cleanest way to add vertical space in Column.'),
            SizedBox(height: 4),
            Text('• SizedBox.expand(): Sets width and height to double.infinity.'),
            SizedBox(height: 4),
            Text('• SizedBox.shrink(): Sets width and height to 0.0.'),
            SizedBox(height: 4),
            Text('• SizedBox.square(dimension: 50): Sets width and height to 50.'),
          ],
        ),
      ),
    );
  }
}
