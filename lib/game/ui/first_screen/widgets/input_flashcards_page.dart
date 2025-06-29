// Create a Form widget.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputFlashcardsPage extends StatefulWidget {
  const InputFlashcardsPage({super.key});

  @override
  InputFlashcardsStateBuilder createState() {
    return InputFlashcardsStateBuilder();
  }
}

class InputFlashcardsStateBuilder extends State<InputFlashcardsPage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _subjectController = TextEditingController();
  final _aiOutputController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _aiOutputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final smallHeadline = theme.textTheme.headlineSmall!.copyWith(
      color: Color.fromARGB(255, 47, 48, 44),
    );
    // Build a Form widget using the _formKey created above.
    return Material(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(16, 16, 8, 16),
                        child: Text(
                          "1. Name your flashcard stack subject",
                          style: smallHeadline,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(16),
                        child: TextFormField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            hintText: 'Name your flashcard stack',
                            labelText: 'Flashcard Stack Subject',
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(16, 0, 16, 8),
                        child: Text(
                          "2. Describe exactly the type of flashcards you're looking for as a part of the AI prompt",
                          style: smallHeadline,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: TextFormField(
                          controller: _subjectController,
                          decoration: const InputDecoration(
                            hintText:
                                'Describe the type of flashcards you want in your flashcard stack',
                            labelText: 'Flashcard Stack Details',
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(16, 0, 16, 8),
                        child: Text(
                          "3. Copy the prompt and paste into ChatGPT or other AI to produce a stack of flashcards",
                          style: smallHeadline,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 64,
                        margin: EdgeInsets.all(16),
                        child: TextButton(
                          onPressed: () {
                            String subjectText = _subjectController.text;
                            String prompt =
                                '''Can you please create json text about the subject $subjectText with 100 flashcards or less? It should match the following format exactly:
                              {
                              "Category": "MLB Locations and Team Names",
                              "Flashcards": [
                              {
                              "Question": "Arizona",
                              "Answer": "Diamondbacks"
                              },
                              }''';
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              Clipboard.setData(
                                ClipboardData(text: prompt),
                              ).then((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "AI prompt copied to clipboard",
                                    ),
                                  ),
                                );
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Missing text in title or description fields',
                                  ),
                                ),
                              );
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll<Color>(
                              Color.fromARGB(255, 255, 170, 90),
                            ),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                          ),
                          child: Text(
                            "Copy AI Prompt",
                            style: TextStyle(
                              color: Color.fromARGB(255, 47, 48, 44),
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(16, 0, 8, 16),
                        child: Text(
                          "4. Paste AI output in the text field below",
                          style: smallHeadline,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                              hintText: 'AI flashcard stack Output',
                              labelText: 'Flashcard Stack from AI',
                            ),
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
    );
  }
}
