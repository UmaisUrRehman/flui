import 'package:flutter/material.dart';
import '../models/widget_topic.dart';
import '../models/quiz_question.dart';

class WidgetData {
  static final List<WidgetTopic> coreWidgets = [
    const WidgetTopic(
      id: 'container',
      name: 'Container',
      category: 'Single-Child Layout & Decoration',
      shortDescription: 'Combines common painting, positioning, and sizing widgets into one.',
      fullDescription: 'Container is a convenience widget that combines common painting, positioning, and sizing widgets. It allows setting background color, borders, rounded corners, padding, margin, width, height, alignment, constraints, and box shadows.',
      icon: Icons.check_box_outline_blank_rounded,
      color: Color(0xFF3B82F6),
      keyFeatures: [
        'Padding & Margin for inner and outer spacing',
        'Decoration (BoxDecoration) for colors, gradients, borders, shadows',
        'Explicit constraints (width, height, constraints)',
        'Child alignment (Alignment.center, topRight, etc.)',
        'Transforms and foreground decorations',
      ],
      codeTemplate: '''Container(
  width: 200.0,
  height: 120.0,
  padding: const EdgeInsets.all(16.0),
  margin: const EdgeInsets.symmetric(vertical: 8.0),
  alignment: Alignment.center,
  decoration: BoxDecoration(
    color: Colors.blueAccent,
    borderRadius: BorderRadius.circular(16.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 10,
        offset: Offset(0, 4),
      ),
    ],
  ),
  child: const Text(
    'Container Box',
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  ),
)''',
      bestUseCases: 'Use Container when you need a single child widget with background decoration, rounded corners, shadows, or combined padding & margin.',
    ),
    const WidgetTopic(
      id: 'row',
      name: 'Row',
      category: 'Multi-Child Horizontal Layout',
      shortDescription: 'Displays its children in a horizontal array.',
      fullDescription: 'Row lays out a list of child widgets side-by-side horizontally. It supports mainAxisAlignment (horizontal distribution), crossAxisAlignment (vertical alignment), and mainAxisSize (occupying min or max horizontal space).',
      icon: Icons.view_column_rounded,
      color: Color(0xFF10B981),
      keyFeatures: [
        'Horizontal child layout direction',
        'mainAxisAlignment: start, end, center, spaceBetween, spaceAround, spaceEvenly',
        'crossAxisAlignment: start, center, end, stretch, baseline',
        'mainAxisSize: MainAxisSize.max (default) or MainAxisSize.min',
        'Requires Expanded or Flexible if children exceed screen width to prevent overflow',
      ],
      codeTemplate: '''Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAlignment.center,
  children: const [
    Icon(Icons.star, color: Colors.amber),
    Text('Rating Score'),
    Chip(label: Text('4.9')),
  ],
)''',
      bestUseCases: 'Use Row to place elements horizontally like buttons beside text, action bars, or user profile statistics.',
    ),
    const WidgetTopic(
      id: 'column',
      name: 'Column',
      category: 'Multi-Child Vertical Layout',
      shortDescription: 'Displays its children in a vertical array.',
      fullDescription: 'Column lays out a list of child widgets vertically stacked from top to bottom. It supports mainAxisAlignment (vertical distribution), crossAxisAlignment (horizontal alignment), and mainAxisSize.',
      icon: Icons.view_stream_rounded,
      color: Color(0xFFF59E0B),
      keyFeatures: [
        'Vertical child layout direction',
        'mainAxisAlignment controls vertical distribution',
        'crossAxisAlignment controls horizontal alignment of children',
        'mainAxisSize.min allows column to shrink-wrap its children',
        'Combine with SingleChildScrollView or ListView if content exceeds viewport',
      ],
      codeTemplate: '''Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: const [
    Text(
      'Welcome Back!',
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    ),
    SizedBox(height: 8),
    Text('Sign in to continue to your dashboard.'),
  ],
)''',
      bestUseCases: 'Use Column for form fields, stacked text blocks, vertical lists, card details, and standard screen content.',
    ),
    const WidgetTopic(
      id: 'stack',
      name: 'Stack',
      category: 'Layered Layout',
      shortDescription: 'Positions children relative to the edges of its box (overlay layout).',
      fullDescription: 'Stack allows child widgets to overlap each other. Children can be positioned relative to the Stack bounds using Positioned widgets or aligned using alignment property.',
      icon: Icons.layers_rounded,
      color: Color(0xFF8B5CF6),
      keyFeatures: [
        'Overlapping z-index layout (first child in list is drawn lowest)',
        'Positioned child widget (top, bottom, left, right, width, height)',
        'Stack alignment (Alignment.topRight, Alignment.bottomCenter)',
        'fit: StackFit.loose, StackFit.expand, or StackFit.passthrough',
        'clipBehavior: Clip.hardEdge, Clip.none to control overflow visibility',
      ],
      codeTemplate: '''Stack(
  children: [
    Image.network('https://picsum.photos/300/200', fit: BoxFit.cover),
    Positioned(
      bottom: 12,
      left: 12,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        color: Colors.black70,
        child: const Text('Live Stream', style: TextStyle(color: Colors.white)),
      ),
    ),
    const Positioned(
      top: 12,
      right: 12,
      child: CircleAvatar(
        radius: 12,
        backgroundColor: Colors.green,
      ),
    ),
  ],
)''',
      bestUseCases: 'Use Stack for badges on icons, image overlay captions, floating action buttons, card banners, and custom interactive widgets.',
    ),
    const WidgetTopic(
      id: 'expanded',
      name: 'Expanded',
      category: 'Flex Layout (Strict)',
      shortDescription: 'Expands a child of a Row, Column, or Flex to fill available space.',
      fullDescription: 'Expanded forces a child of a Row, Column, or Flex to expand to fill all remaining available space along the main axis. If multiple children are expanded, space is distributed according to flex factors.',
      icon: Icons.fullscreen_rounded,
      color: Color(0xFFEC4899),
      keyFeatures: [
        'Must be a direct child of Row, Column, or Flex',
        'Forces child to fill available space (FlexFit.tight)',
        'flex property (int): relative weight (e.g. flex: 2 gets twice space of flex: 1)',
        'Eliminates unbounded overflow errors when wrapping long text inside Row',
      ],
      codeTemplate: '''Row(
  children: [
    const Icon(Icons.description),
    const SizedBox(width: 8),
    Expanded(
      flex: 2,
      child: const Text(
        'Very long description title that wraps cleanly without overflowing',
      ),
    ),
    Expanded(
      flex: 1,
      child: ElevatedButton(
        onPressed: () {},
        child: const Text('Action'),
      ),
    ),
  ],
)''',
      bestUseCases: 'Use Expanded when a widget MUST take up all remaining available space or when balancing space proportionally between children.',
    ),
    const WidgetTopic(
      id: 'flexible',
      name: 'Flexible',
      category: 'Flex Layout (Loose)',
      shortDescription: 'Controls how a child of a Row, Column, or Flex flexes without forcing expansion.',
      fullDescription: 'Flexible gives a child of a Row, Column, or Flex the ability to expand up to maximum available space, but permits the child to shrink to its natural size (FlexFit.loose by default).',
      icon: Icons.unfold_more_rounded,
      color: Color(0xFF06B6D4),
      keyFeatures: [
        'Must be a direct child of Row, Column, or Flex',
        'fit: FlexFit.loose (child can be smaller than max allocated space)',
        'fit: FlexFit.tight (equivalent to Expanded widget)',
        'flex: relative ratio weight for allocating max available space',
      ],
      codeTemplate: '''Row(
  children: [
    Flexible(
      fit: FlexFit.loose,
      flex: 1,
      child: Container(
        color: Colors.teal,
        child: const Text('Flexible Loose Child'),
      ),
    ),
    Expanded(
      flex: 2,
      child: Container(
        color: Colors.orange,
        child: const Text('Expanded Tight Child'),
      ),
    ),
  ],
)''',
      bestUseCases: 'Use Flexible when you want a widget to shrink if space is constrained, but not force it to stretch if it doesn\'t need to.',
    ),
    const WidgetTopic(
      id: 'sizedbox',
      name: 'SizedBox',
      category: 'Fixed Dimensions & Spacing',
      shortDescription: 'A box with a specified size or empty spacing helper.',
      fullDescription: 'SizedBox forces its child to have a specific width and/or height. If given no child, it creates empty space between widgets in Row or Column. Also provides constructors like SizedBox.expand() and SizedBox.shrink().',
      icon: Icons.aspect_ratio_rounded,
      color: Color(0xFF6366F1),
      keyFeatures: [
        'Explicit fixed width & height',
        'Efficient whitespace spacing in Row and Column',
        'SizedBox.expand() forces child to match parent constraints',
        'SizedBox.shrink() reduces child to 0 width & height',
        'SizedBox.square(dimension: 50) sets equal width and height',
      ],
      codeTemplate: '''Column(
  children: [
    const Text('Header Title'),
    const SizedBox(height: 16), // Spacing
    const Text('Subtitle text'),
    const SizedBox(height: 24),
    SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () {},
        child: const Text('Full Width Button'),
      ),
    ),
  ],
)''',
      bestUseCases: 'Use SizedBox for fixed gaps between elements in Row/Column, giving precise dimensions to buttons or inputs, or expanding to full parent size.',
    ),
  ];

  static final List<QuizQuestion> quizQuestions = [
    const QuizQuestion(
      id: 'q1',
      question: 'Which core widget is best for adding padding, background color, rounded corners, and border shadows to a single child?',
      options: ['Column', 'Container', 'SizedBox', 'Expanded'],
      correctAnswerIndex: 1,
      explanation: 'Container combines padding, margin, decoration (color, border, shadow), alignment, and sizing into a single convenient widget.',
      widgetTag: 'Container',
    ),
    const QuizQuestion(
      id: 'q2',
      question: 'How do you create fixed vertical spacing between two items in a Column widget?',
      options: ['Use SizedBox(height: 16)', 'Use Expanded(flex: 16)', 'Use Stack(bottom: 16)', 'Use Row(width: 16)'],
      correctAnswerIndex: 0,
      explanation: 'SizedBox(height: 16) is the standard and most performant way to insert vertical whitespace inside a Column.',
      widgetTag: 'SizedBox',
    ),
    const QuizQuestion(
      id: 'q3',
      question: 'What happens when a child inside a Row extends beyond the screen width without being wrapped in Expanded or Flexible?',
      options: [
        'The Row automatically scrolls horizontally',
        'The child shrinks automatically',
        'A yellow and black striped overflow warning appears on screen',
        'The app crashes instantly'
      ],
      correctAnswerIndex: 2,
      explanation: 'Unbounded children in Row/Column that exceed the available space cause a visual overflow warning (yellow/black banner).',
      widgetTag: 'Row',
    ),
    const QuizQuestion(
      id: 'q4',
      question: 'What is the main difference between Expanded and Flexible with FlexFit.loose?',
      options: [
        'Expanded only works in Stack while Flexible works in Row',
        'Expanded forces the child to take all allocated space (FlexFit.tight), whereas Flexible allows the child to shrink to its natural size',
        'Flexible can only be used with text',
        'There is no difference between them'
      ],
      correctAnswerIndex: 1,
      explanation: 'Expanded sets fit to FlexFit.tight, forcing the child to fill the space. Flexible defaults to FlexFit.loose, allowing it to occupy only as much space as needed up to its flex limit.',
      widgetTag: 'Expanded vs Flexible',
    ),
    const QuizQuestion(
      id: 'q5',
      question: 'Which widget allows widgets to layer on top of each other along the z-axis (e.g. a notification badge over an icon)?',
      options: ['Row', 'Column', 'Stack', 'Expanded'],
      correctAnswerIndex: 2,
      explanation: 'Stack overlays its children on top of one another. Positioned widgets inside Stack allow pinpoint positioning of overlays.',
      widgetTag: 'Stack',
    ),
    const QuizQuestion(
      id: 'q6',
      question: 'In a Row, which property controls how children are aligned along the horizontal (main) axis?',
      options: ['crossAxisAlignment', 'mainAxisAlignment', 'alignment', 'flexDirection'],
      correctAnswerIndex: 1,
      explanation: 'mainAxisAlignment controls layout along the main axis (horizontal for Row, vertical for Column).',
      widgetTag: 'Row',
    ),
    const QuizQuestion(
      id: 'q7',
      question: 'If you have two Expanded widgets inside a Row with flex: 2 and flex: 1, how is space divided?',
      options: [
        'First takes 50%, second takes 50%',
        'First takes 2/3 (66.7%), second takes 1/3 (33.3%)',
        'First takes 100%, second gets hidden',
        'First takes 20 pixels, second takes 10 pixels'
      ],
      correctAnswerIndex: 1,
      explanation: 'Total flex sum is 2 + 1 = 3. The first widget gets 2/3 of available space and the second gets 1/3.',
      widgetTag: 'Expanded',
    ),
    const QuizQuestion(
      id: 'q8',
      question: 'What does SizedBox.expand() do when placed inside a bounded parent?',
      options: [
        'Shrinks the child to 0 pixels width and height',
        'Forces its child to fill the maximum width and height allowed by the parent constraints',
        'Makes the background transparent',
        'Renders an animated expansion box'
      ],
      correctAnswerIndex: 1,
      explanation: 'SizedBox.expand() sets width and height to double.infinity, forcing the box to match parent constraints.',
      widgetTag: 'SizedBox',
    ),
  ];
}
