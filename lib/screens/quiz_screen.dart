import 'package:flutter/material.dart';
import '../data/widget_data.dart';
import '../models/quiz_question.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedAnswerIndex;
  bool _answered = false;

  final List<QuizQuestion> _questions = WidgetData.quizQuestions;

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentIndex];
    final progress = (_currentIndex + 1) / _questions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Layout Mastery Quiz (${_currentIndex + 1}/${_questions.length})'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: Colors.grey.shade200,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 20),

            // Question Card
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.indigo.shade50,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            question.widgetTag.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        Text(
                          'Score: $_score',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      question.question,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 1.3),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Options List
            ...List.generate(question.options.length, (index) {
              final optionText = question.options[index];
              final isSelected = _selectedAnswerIndex == index;
              final isCorrect = index == question.correctAnswerIndex;

              Color optionColor = Colors.white;
              Color borderColor = Colors.grey.shade300;
              IconData? icon;

              if (_answered) {
                if (isCorrect) {
                  optionColor = Colors.green.shade50;
                  borderColor = Colors.green;
                  icon = Icons.check_circle_rounded;
                } else if (isSelected) {
                  optionColor = Colors.red.shade50;
                  borderColor = Colors.red;
                  icon = Icons.cancel_rounded;
                }
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  onTap: _answered ? null : () => _handleAnswerSelect(index),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: optionColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: borderColor, width: isSelected || (_answered && isCorrect) ? 2 : 1),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 6, offset: const Offset(0, 2)),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade100,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            String.fromCharCode(65 + index), // A, B, C, D
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            optionText,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                        if (icon != null) Icon(icon, color: borderColor),
                      ],
                    ),
                  ),
                ),
              );
            }),

            const SizedBox(height: 12),

            // Explanation Box
            if (_answered) ...[
              Card(
                color: Colors.blue.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.blue.shade200),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.info_outline_rounded, color: Colors.blue),
                          SizedBox(width: 8),
                          Text('Explanation', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        question.explanation,
                        style: const TextStyle(fontSize: 13, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _nextQuestion,
                child: Text(_currentIndex < _questions.length - 1 ? 'Next Question' : 'View Results'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _handleAnswerSelect(int index) {
    setState(() {
      _selectedAnswerIndex = index;
      _answered = true;
      if (index == _questions[_currentIndex].correctAnswerIndex) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedAnswerIndex = null;
        _answered = false;
      });
    } else {
      _showResultsDialog();
    }
  }

  void _showResultsDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final percentage = ((_score / _questions.length) * 100).toInt();
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Quiz Completed! 🎉', textAlign: TextAlign.center),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$percentage%',
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.indigo),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'You scored $_score out of ${_questions.length}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                percentage >= 75
                    ? 'Excellent job! You have mastered Flutter core layout widgets!'
                    : 'Good effort! Review the playgrounds to solidify your understanding.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _currentIndex = 0;
                  _score = 0;
                  _selectedAnswerIndex = null;
                  _answered = false;
                });
              },
              child: const Text('Retake Quiz'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Back to Home'),
            ),
          ],
        );
      },
    );
  }
}
