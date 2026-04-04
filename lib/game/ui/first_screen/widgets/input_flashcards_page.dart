// Create a Form widget.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../common/viewmodel/game_view_model.dart';
import '../../flashcard/quiz_page.dart';

class InputFlashcardsPage extends StatefulWidget {
  const InputFlashcardsPage({super.key});

  @override
  InputFlashcardsStateBuilder createState() {
    return InputFlashcardsStateBuilder();
  }
}

class InputFlashcardsStateBuilder extends State<InputFlashcardsPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _subjectController;
  late final TextEditingController _aiOutputController;

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<GameViewModel>(context, listen: false);
    _titleController = TextEditingController(text: appState.category);
    _subjectController = TextEditingController();
    _aiOutputController = TextEditingController(text: appState.jsonText);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subjectController.dispose();
    _aiOutputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use read instead of watch to prevent rebuilds while typing
    final appState = context.read<GameViewModel>();
    final theme = Theme.of(context);
    final smallHeadline = theme.textTheme.headlineSmall!.copyWith(
      color: const Color.fromARGB(255, 47, 48, 44),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "1. Name your flashcard stack subject",
                      style: smallHeadline,
                    ),
                  ),
                  TextFormField(
                    controller: _titleController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: 'Name your flashcard stack',
                      labelText: 'Flashcard Stack Subject',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(16),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onChanged: (value) => appState.category = value,
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "2. Describe what will appear on the question and answer sides of the card, and any additional details",
                      style: smallHeadline,
                    ),
                  ),
                  TextFormField(
                    controller: _subjectController,
                    maxLines: 3,
                    textInputAction: TextInputAction.newline,
                    decoration: const InputDecoration(
                      hintText: 'Define what will appear on question and answer side of the card',
                      labelText: 'Flashcard Stack Details',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                      contentPadding: EdgeInsets.all(16),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 64,
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() == true) {
                          String subjectText = _subjectController.text;
                          String titleText = _titleController.text;
                          String prompt =
                              '''Can you please create json text about the subject $titleText with description $subjectText with 25 flashcards? It should match the following format exactly:
{
  "Category": "${_titleController.text}",
  "Flashcards": [
    {
      "Question": "Example Question",
      "Answer": "Example Answer"
    }
  ]
}''';
                          Clipboard.setData(ClipboardData(text: prompt)).then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("AI prompt copied to clipboard")),
                            );
                          });
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 170, 90),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text(
                        "3. Copy AI Prompt",
                        style: TextStyle(color: Color.fromARGB(255, 47, 48, 44), fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "4. Paste AI output below",
                      style: smallHeadline,
                    ),
                  ),
                  TextFormField(
                    controller: _aiOutputController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 8,
                    // scrollPadding ensures the field is visible above the keyboard
                    scrollPadding: const EdgeInsets.only(bottom: 100),
                    decoration: const InputDecoration(
                      hintText: 'Paste the JSON from AI here...',
                      labelText: 'Flashcard Stack from AI',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                      contentPadding: EdgeInsets.all(16),
                    ),
                    onChanged: (value) => appState.jsonText = value,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 84,
                    child: TextButton(
                      onPressed: () {
                        String aiOutputText = _aiOutputController.text;
                        if (aiOutputText.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please input flashcard stack from AI")),
                          );
                        } else {
                          appState.jsonText = aiOutputText;
                          appState.category = _titleController.text;
                          Navigator.of(context).pop();
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => QuizPage()),
                          );
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 170, 90),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text(
                        "Submit Flashcards and Continue",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color.fromARGB(255, 47, 48, 44), fontSize: 24),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
