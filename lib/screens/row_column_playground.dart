import 'package:flutter/material.dart';
import '../data/widget_data.dart';
import '../widgets/code_snippet_view.dart';
import '../widgets/interactive_header.dart';

class RowColumnPlayground extends StatefulWidget {
  const RowColumnPlayground({super.key});

  @override
  State<RowColumnPlayground> createState() => _RowColumnPlaygroundState();
}

class _RowColumnPlaygroundState extends State<RowColumnPlayground> {
  bool _isRow = true; // true = Row, false = Column
  MainAxisAlignment _mainAxisAlignment = MainAxisAlignment.spaceAround;
  CrossAxisAlignment _crossAxisAlignment = CrossAxisAlignment.center;
  MainAxisSize _mainAxisSize = MainAxisSize.max;
  int _itemCount = 3;
  bool _variableItemSizes = true;

  final Map<String, MainAxisAlignment> _mainAlignments = {
    'start': MainAxisAlignment.start,
    'center': MainAxisAlignment.center,
    'end': MainAxisAlignment.end,
    'spaceBetween': MainAxisAlignment.spaceBetween,
    'spaceAround': MainAxisAlignment.spaceAround,
    'spaceEvenly': MainAxisAlignment.spaceEvenly,
  };

  final Map<String, CrossAxisAlignment> _crossAlignments = {
    'start': CrossAxisAlignment.start,
    'center': CrossAxisAlignment.center,
    'end': CrossAxisAlignment.end,
    'stretch': CrossAxisAlignment.stretch,
  };

  @override
  Widget build(BuildContext context) {
    final topic = WidgetData.coreWidgets.firstWhere((w) => w.id == (_isRow ? 'row' : 'column'));

    return Scaffold(
      appBar: AppBar(
        title: Text('${_isRow ? "Row" : "Column"} Playground'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InteractiveHeader(
              title: _isRow ? 'Row Widget' : 'Column Widget',
              category: topic.category,
              description: topic.shortDescription,
              icon: topic.icon,
              color: topic.color,
            ),
            const SizedBox(height: 20),

            // Mode Selector Bar
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment<bool>(
                  value: true,
                  label: Text('Row (Horizontal)'),
                  icon: Icon(Icons.view_column_rounded),
                ),
                ButtonSegment<bool>(
                  value: false,
                  label: Text('Column (Vertical)'),
                  icon: Icon(Icons.view_stream_rounded),
                ),
              ],
              selected: {_isRow},
              onSelectionChanged: (set) {
                setState(() {
                  _isRow = set.first;
                });
              },
            ),
            const SizedBox(height: 20),

            // Live Interactive Canvas
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Visual Canvas (${_isRow ? "Main Axis: Horizontal" : "Main Axis: Vertical"})',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: topic.color.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'mainAxisSize: ${_mainAxisSize.name}',
                            style: TextStyle(
                              color: topic.color,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      height: 260,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade400, style: BorderStyle.solid),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: topic.color, width: 2),
                              color: topic.color.withValues(alpha: 0.05),
                            ),
                            child: _isRow
                                ? Row(
                                    mainAxisAlignment: _mainAxisAlignment,
                                    crossAxisAlignment: _crossAxisAlignment,
                                    mainAxisSize: _mainAxisSize,
                                    children: _generateChildren(),
                                  )
                                : Column(
                                    mainAxisAlignment: _mainAxisAlignment,
                                    crossAxisAlignment: _crossAxisAlignment,
                                    mainAxisSize: _mainAxisSize,
                                    children: _generateChildren(),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Controls Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Layout Axis & Alignment Controls',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),

                    // mainAxisAlignment
                    DropdownButtonFormField<MainAxisAlignment>(
                      value: _mainAxisAlignment,
                      decoration: const InputDecoration(
                        labelText: 'MainAxisAlignment (Main Axis)',
                        border: OutlineInputBorder(),
                      ),
                      items: _mainAlignments.entries.map((e) {
                        return DropdownMenuItem(
                          value: e.value,
                          child: Text('MainAxisAlignment.${e.key}'),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _mainAxisAlignment = val);
                      },
                    ),
                    const SizedBox(height: 16),

                    // crossAxisAlignment
                    DropdownButtonFormField<CrossAxisAlignment>(
                      value: _crossAxisAlignment,
                      decoration: const InputDecoration(
                        labelText: 'CrossAxisAlignment (Cross Axis)',
                        border: OutlineInputBorder(),
                      ),
                      items: _crossAlignments.entries.map((e) {
                        return DropdownMenuItem(
                          value: e.value,
                          child: Text('CrossAxisAlignment.${e.key}'),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _crossAxisAlignment = val);
                      },
                    ),
                    const SizedBox(height: 16),

                    // mainAxisSize & Options
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<MainAxisSize>(
                            value: _mainAxisSize,
                            decoration: const InputDecoration(
                              labelText: 'MainAxisSize',
                              border: OutlineInputBorder(),
                            ),
                            items: const [
                              DropdownMenuItem(value: MainAxisSize.max, child: Text('MainAxisSize.max')),
                              DropdownMenuItem(value: MainAxisSize.min, child: Text('MainAxisSize.min')),
                            ],
                            onChanged: (val) {
                              if (val != null) setState(() => _mainAxisSize = val);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    Row(
                      children: [
                        const Text('Children Count: ', style: TextStyle(fontWeight: FontWeight.w600)),
                        Text('$_itemCount', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)),
                        Expanded(
                          child: Slider(
                            value: _itemCount.toDouble(),
                            min: 2,
                            max: 5,
                            divisions: 3,
                            label: '$_itemCount items',
                            onChanged: (val) => setState(() => _itemCount = val.toInt()),
                          ),
                        ),
                      ],
                    ),

                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Vary Child Heights/Widths', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                      subtitle: const Text('Shows crossAxisAlignment impact on children of varying sizes'),
                      value: _variableItemSizes,
                      onChanged: (v) => setState(() => _variableItemSizes = v),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Generated Code
            CodeSnippetView(
              code: _generateCodeSnippet(),
              title: '${_isRow ? "Row" : "Column"} Code Example',
            ),
            const SizedBox(height: 20),

            // Core Takeaways Card
            _buildConceptCard(),
          ],
        ),
      ),
    );
  }

  List<Widget> _generateChildren() {
    final colors = [
      Colors.indigo,
      Colors.teal,
      Colors.orange,
      Colors.pink,
      Colors.purple,
    ];

    return List.generate(_itemCount, (index) {
      final sizeBonus = _variableItemSizes ? (index * 12) : 0;
      final width = _isRow ? 45.0 : 45.0 + sizeBonus;
      final height = _isRow ? 45.0 + sizeBonus : 45.0;

      return Container(
        width: _crossAxisAlignment == CrossAxisAlignment.stretch && !_isRow ? null : width,
        height: _crossAxisAlignment == CrossAxisAlignment.stretch && _isRow ? null : height,
        margin: const EdgeInsets.all(4),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: colors[index % colors.length],
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
          ],
        ),
        child: Text(
          '#${index + 1}',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
      );
    });
  }

  String _generateCodeSnippet() {
    final widgetName = _isRow ? 'Row' : 'Column';
    final mainAlign = _mainAxisAlignment.toString().split('.').last;
    final crossAlign = _crossAxisAlignment.toString().split('.').last;
    final mainSize = _mainAxisSize.toString().split('.').last;

    return '''$widgetName(
  mainAxisAlignment: MainAxisAlignment.$mainAlign,
  crossAxisAlignment: CrossAxisAlignment.$crossAlign,
  mainAxisSize: MainAxisSize.$mainSize,
  children: [
    Container(width: 45, height: 45, color: Colors.indigo, child: Text("#1")),
    Container(width: 45, height: ${_variableItemSizes ? 57 : 45}, color: Colors.teal, child: Text("#2")),
    Container(width: 45, height: ${_variableItemSizes ? 69 : 45}, color: Colors.orange, child: Text("#3")),
  ],
)''';
  }

  Widget _buildConceptCard() {
    const tealColor = Colors.teal;
    return Card(
      color: tealColor.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: tealColor.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Row(
              children: [
                Icon(Icons.swap_horiz_rounded, color: tealColor),
                SizedBox(width: 8),
                Text(
                  'Row & Column Axis Rules',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: tealColor),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text('• Row Main Axis: Horizontal (X-Axis) | Cross Axis: Vertical (Y-Axis)'),
            SizedBox(height: 4),
            Text('• Column Main Axis: Vertical (Y-Axis) | Cross Axis: Horizontal (X-Axis)'),
            SizedBox(height: 4),
            Text('• mainAxisSize.min: Takes only as much room as children require.'),
            SizedBox(height: 4),
            Text('• Overflow Warning: If children exceed main axis limits without Expanded/Flexible, an overflow error triggers.'),
          ],
        ),
      ),
    );
  }
}
