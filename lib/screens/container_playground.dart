import 'package:flutter/material.dart';
import '../data/widget_data.dart';
import '../models/widget_topic.dart';
import '../widgets/code_snippet_view.dart';
import '../widgets/interactive_header.dart';

class ContainerPlayground extends StatefulWidget {
  const ContainerPlayground({super.key});

  @override
  State<ContainerPlayground> createState() => _ContainerPlaygroundState();
}

class _ContainerPlaygroundState extends State<ContainerPlayground> {
  double _width = 200;
  double _height = 150;
  double _padding = 16;
  double _margin = 16;
  double _borderRadius = 16;
  double _borderWidth = 2;
  double _shadowBlur = 10;
  bool _useGradient = false;
  Color _selectedColor = Colors.indigo;
  Alignment _alignment = Alignment.center;
  String _childType = 'Text';

  final List<Color> _colorOptions = [
    Colors.indigo,
    Colors.deepPurple,
    Colors.teal,
    Colors.orange,
    Colors.pink,
    Colors.blueGrey,
  ];

  final Map<String, Alignment> _alignmentMap = {
    'Center': Alignment.center,
    'Top Left': Alignment.topLeft,
    'Top Right': Alignment.topRight,
    'Bottom Left': Alignment.bottomLeft,
    'Bottom Right': Alignment.bottomRight,
  };

  @override
  Widget build(BuildContext context) {
    final topic = WidgetData.coreWidgets.firstWhere((w) => w.id == 'container');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Container Playground'),
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

            // Live Preview Canvas
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Live Preview Canvas',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Icon(Icons.touch_app_rounded, color: Colors.indigo, size: 20),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      height: 260,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Center(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: _width,
                          height: _height,
                          padding: EdgeInsets.all(_padding),
                          margin: EdgeInsets.all(_margin),
                          alignment: _alignment,
                          decoration: BoxDecoration(
                            color: _useGradient ? null : _selectedColor,
                            gradient: _useGradient
                                ? LinearGradient(
                                    colors: [_selectedColor, Colors.cyanAccent.shade700],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : null,
                            borderRadius: BorderRadius.circular(_borderRadius),
                            border: Border.all(
                              color: Colors.black.withValues(alpha: 0.2),
                              width: _borderWidth,
                            ),
                            boxShadow: _shadowBlur > 0
                                ? [
                                    BoxShadow(
                                      color: _selectedColor.withValues(alpha: 0.4),
                                      blurRadius: _shadowBlur,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                : [],
                          ),
                          child: _buildChildWidget(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Interactive Controls Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Interactive Property Controls',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),

                    // Dimensions
                    _buildSliderRow('Width', _width, 100, 280, (v) => setState(() => _width = v)),
                    _buildSliderRow('Height', _height, 60, 200, (v) => setState(() => _height = v)),
                    _buildSliderRow('Padding', _padding, 0, 32, (v) => setState(() => _padding = v)),
                    _buildSliderRow('Margin', _margin, 0, 32, (v) => setState(() => _margin = v)),
                    _buildSliderRow('Border Radius', _borderRadius, 0, 40, (v) => setState(() => _borderRadius = v)),
                    _buildSliderRow('Border Width', _borderWidth, 0, 10, (v) => setState(() => _borderWidth = v)),
                    _buildSliderRow('Box Shadow Blur', _shadowBlur, 0, 30, (v) => setState(() => _shadowBlur = v)),

                    const Divider(height: 24),

                    // Color Picker
                    const Text('Background Color:', style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Row(
                      children: _colorOptions.map((color) {
                        final isSelected = _selectedColor == color;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedColor = color),
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border: isSelected ? Border.all(color: Colors.black, width: 3) : null,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 16),

                    // Switches & Dropdowns
                    Row(
                      children: [
                        Expanded(
                          child: SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Use Gradient', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                            value: _useGradient,
                            onChanged: (v) => setState(() => _useGradient = v),
                          ),
                        ),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _alignmentMap.entries.firstWhere((e) => e.value == _alignment).key,
                            decoration: const InputDecoration(
                              labelText: 'Alignment',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            ),
                            items: _alignmentMap.keys.map((name) {
                              return DropdownMenuItem(value: name, child: Text(name));
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => _alignment = _alignmentMap[val]!);
                              }
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Text('Child Type: ', style: TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(width: 12),
                        SegmentedButton<String>(
                          segments: const [
                            ButtonSegment(value: 'Text', label: Text('Text')),
                            ButtonSegment(value: 'Icon', label: Text('Icon')),
                            ButtonSegment(value: 'Badge', label: Text('Badge')),
                          ],
                          selected: {_childType},
                          onSelectionChanged: (val) {
                            setState(() => _childType = val.first);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Live Generated Code Snippet
            CodeSnippetView(
              code: _generateCodeSnippet(),
              title: 'Dynamic Container Snippet',
            ),
            const SizedBox(height: 20),

            // Key Takeaways Card
            _buildKeyTakeawaysCard(topic),
          ],
        ),
      ),
    );
  }

  Widget _buildChildWidget() {
    switch (_childType) {
      case 'Icon':
        return const Icon(Icons.flash_on_rounded, color: Colors.white, size: 36);
      case 'Badge':
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.check_circle_rounded, color: Colors.white, size: 18),
            SizedBox(width: 6),
            Text(
              'PRO MEMBER',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ],
        );
      case 'Text':
      default:
        return const Text(
          'Container Box',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        );
    }
  }

  Widget _buildSliderRow(String label, double value, double min, double max, ValueChanged<double> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text('$label: ${value.toStringAsFixed(0)}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
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
    final alignName = _alignmentMap.entries.firstWhere((e) => e.value == _alignment).key.replaceAll(' ', '');

    final decorationBuffer = StringBuffer('BoxDecoration(\n');
    if (_useGradient) {
      decorationBuffer.writeln('    gradient: LinearGradient(');
      decorationBuffer.writeln('      colors: [Colors.indigo, Colors.cyanAccent],');
      decorationBuffer.writeln('    ),');
    } else {
      decorationBuffer.writeln('    color: Colors.indigo,');
    }
    decorationBuffer.writeln('    borderRadius: BorderRadius.circular(${_borderRadius.toStringAsFixed(0)}),');
    if (_borderWidth > 0) {
      decorationBuffer.writeln('    border: Border.all(color: Colors.black26, width: ${_borderWidth.toStringAsFixed(0)}),');
    }
    if (_shadowBlur > 0) {
      decorationBuffer.writeln('    boxShadow: [');
      decorationBuffer.writeln('      BoxShadow(color: Colors.black26, blurRadius: ${_shadowBlur.toStringAsFixed(0)}, offset: Offset(0, 4)),');
      decorationBuffer.writeln('    ],');
    }
    decorationBuffer.write('  )');

    return '''Container(
  width: ${_width.toStringAsFixed(0)}.0,
  height: ${_height.toStringAsFixed(0)}.0,
  padding: const EdgeInsets.all(${_padding.toStringAsFixed(0)}.0),
  margin: const EdgeInsets.all(${_margin.toStringAsFixed(0)}.0),
  alignment: Alignment.$alignName,
  decoration: ${decorationBuffer.toString()},
  child: const ${_childType == 'Icon' ? 'Icon(Icons.flash_on_rounded, color: Colors.white)' : 'Text("Container Box")'},
)''';
  }

  Widget _buildKeyTakeawaysCard(WidgetTopic topic) {
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
          children: [
            Row(
              children: const [
                Icon(Icons.lightbulb_rounded, color: Colors.indigo),
                SizedBox(width: 8),
                Text(
                  'Core Mastery Concepts: Container',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.indigo),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...topic.keyFeatures.map(
              (feature) => Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)),
                    Expanded(
                      child: Text(
                        feature,
                        style: const TextStyle(fontSize: 13, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
