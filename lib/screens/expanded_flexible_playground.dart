import 'package:flutter/material.dart';
import '../data/widget_data.dart';
import '../widgets/code_snippet_view.dart';
import '../widgets/interactive_header.dart';

class ExpandedFlexiblePlayground extends StatefulWidget {
  const ExpandedFlexiblePlayground({super.key});

  @override
  State<ExpandedFlexiblePlayground> createState() => _ExpandedFlexiblePlaygroundState();
}

class _ExpandedFlexiblePlaygroundState extends State<ExpandedFlexiblePlayground> {
  int _item1Flex = 1;
  int _item2Flex = 2;
  int _item3Flex = 1;

  FlexFit _item1Fit = FlexFit.tight; // tight = Expanded
  FlexFit _item2Fit = FlexFit.tight;
  FlexFit _item3Fit = FlexFit.tight;

  bool _includeFixedWidget = true;

  @override
  Widget build(BuildContext context) {
    final topic = WidgetData.coreWidgets.firstWhere((w) => w.id == 'expanded');
    final totalFlex = _item1Flex + _item2Flex + _item3Flex;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expanded vs Flexible Lab'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InteractiveHeader(
              title: 'Expanded & Flexible',
              category: 'Flex Space Allocation',
              description: 'Compare Expanded (FlexFit.tight) and Flexible (FlexFit.loose) to master proportional space distribution.',
              icon: topic.icon,
              color: topic.color,
            ),
            const SizedBox(height: 20),

            // Live Flex Bar Canvas
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Flex Space Distribution Bar',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.pink.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.pink.shade200),
                          ),
                          child: Text(
                            'Total Flex Sum: $totalFlex',
                            style: const TextStyle(color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 100,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          if (_includeFixedWidget) ...[
                            Container(
                              width: 60,
                              height: double.infinity,
                              color: Colors.grey.shade700,
                              alignment: Alignment.center,
                              child: const Text(
                                'Fixed\n60px',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: 6),
                          ],
                          Flexible(
                            flex: _item1Flex,
                            fit: _item1Fit,
                            child: Container(
                              height: double.infinity,
                              color: Colors.pinkAccent,
                              alignment: Alignment.center,
                              child: Text(
                                'Item 1\n(${_item1Fit == FlexFit.tight ? "Expanded" : "Flexible"})\nflex: $_item1Flex',
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            flex: _item2Flex,
                            fit: _item2Fit,
                            child: Container(
                              height: double.infinity,
                              color: Colors.indigo,
                              alignment: Alignment.center,
                              child: Text(
                                'Item 2\n(${_item2Fit == FlexFit.tight ? "Expanded" : "Flexible"})\nflex: $_item2Flex',
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            flex: _item3Flex,
                            fit: _item3Fit,
                            child: Container(
                              height: double.infinity,
                              color: Colors.teal,
                              alignment: Alignment.center,
                              child: Text(
                                'Item 3\n(${_item3Fit == FlexFit.tight ? "Expanded" : "Flexible"})\nflex: $_item3Flex',
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
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
            const SizedBox(height: 20),

            // Controls
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Flex Factors & Fit Mode Settings',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),

                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Include Fixed Sized Widget (60px)', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                      subtitle: const Text('Shows how remaining space after fixed widgets is shared'),
                      value: _includeFixedWidget,
                      onChanged: (v) => setState(() => _includeFixedWidget = v),
                    ),
                    const Divider(height: 20),

                    // Item 1 Controls
                    _buildItemControlRow('Item 1 (Pink)', _item1Flex, _item1Fit, (flex) => setState(() => _item1Flex = flex), (fit) => setState(() => _item1Fit = fit)),
                    const SizedBox(height: 12),

                    // Item 2 Controls
                    _buildItemControlRow('Item 2 (Indigo)', _item2Flex, _item2Fit, (flex) => setState(() => _item2Flex = flex), (fit) => setState(() => _item2Fit = fit)),
                    const SizedBox(height: 12),

                    // Item 3 Controls
                    _buildItemControlRow('Item 3 (Teal)', _item3Flex, _item3Fit, (flex) => setState(() => _item3Flex = flex), (fit) => setState(() => _item3Fit = fit)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Overflow Prevention Showcase
            _buildTextOverflowDemo(),
            const SizedBox(height: 20),

            // Generated Code Snippet
            CodeSnippetView(
              code: _generateCodeSnippet(),
              title: 'Flex Allocation Code Snippet',
            ),
            const SizedBox(height: 20),

            _buildConceptCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildItemControlRow(String title, int flex, FlexFit fit, ValueChanged<int> onFlexChanged, ValueChanged<FlexFit> onFitChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            Row(
              children: [
                ChoiceChip(
                  label: const Text('Expanded (Tight)', style: TextStyle(fontSize: 11)),
                  selected: fit == FlexFit.tight,
                  onSelected: (selected) {
                    if (selected) onFitChanged(FlexFit.tight);
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Flexible (Loose)', style: TextStyle(fontSize: 11)),
                  selected: fit == FlexFit.loose,
                  onSelected: (selected) {
                    if (selected) onFitChanged(FlexFit.loose);
                  },
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            const Text('Flex Factor: ', style: TextStyle(fontSize: 12)),
            Text('$flex', style: const TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: Slider(
                value: flex.toDouble(),
                min: 1,
                max: 5,
                divisions: 4,
                onChanged: (v) => onFlexChanged(v.toInt()),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextOverflowDemo() {
    return Card(
      color: Colors.amber.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.amber.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.shield_rounded, color: Colors.amber),
                SizedBox(width: 8),
                Text(
                  'Crucial Use-Case: Text Overflow Protection',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.amber),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Wrapping long text in Expanded inside a Row forces the text to wrap into multiple lines instead of pushing past screen edges.',
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: Row(
                children: const [
                  Icon(Icons.mark_email_unread_rounded, color: Colors.indigo),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Important notification: Your account update process completed successfully!',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _generateCodeSnippet() {
    return '''Row(
  children: [
    ${_includeFixedWidget ? 'SizedBox(width: 60.0, child: Text("Fixed")),' : ''}
    Expanded( // FlexFit.tight
      flex: $_item1Flex,
      child: Container(color: Colors.pinkAccent),
    ),
    Flexible( // FlexFit.${_item2Fit.name}
      flex: $_item2Flex,
      fit: FlexFit.${_item2Fit.name},
      child: Container(color: Colors.indigo),
    ),
    Flexible( // FlexFit.${_item3Fit.name}
      flex: $_item3Flex,
      fit: FlexFit.${_item3Fit.name},
      child: Container(color: Colors.teal),
    ),
  ],
)''';
  }

  Widget _buildConceptCard() {
    return Card(
      color: Colors.pink.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.pink.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Row(
              children: [
                Icon(Icons.aspect_ratio_rounded, color: Colors.pink),
                SizedBox(width: 8),
                Text(
                  'Expanded vs Flexible Comparison',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.pink),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text('• Expanded == Flexible(fit: FlexFit.tight). Forces child to fill max available flex space.'),
            SizedBox(height: 4),
            Text('• Flexible(fit: FlexFit.loose) allows child to shrink to its natural size if smaller than space.'),
            SizedBox(height: 4),
            Text('• Flex ratio: Space allocated = (child_flex / sum_of_all_flexes) * remaining_space.'),
          ],
        ),
      ),
    );
  }
}
