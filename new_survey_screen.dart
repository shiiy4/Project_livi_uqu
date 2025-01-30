import 'package:flutter/material.dart';

class NewSurveyScreen extends StatefulWidget {
  const NewSurveyScreen({super.key});

  @override
  _NewSurveyScreenState createState() => _NewSurveyScreenState();
}

class _NewSurveyScreenState extends State<NewSurveyScreen> {
  final List<TextEditingController> questionControllers = [];
  int questionCount = 1;

  @override
  void initState() {
    super.initState();
    questionControllers.add(TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in questionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void addQuestion() {
    setState(() {
      questionCount++;
      questionControllers.add(TextEditingController());
    });
  }

  void removeQuestion(int index) {
    setState(() {
      if (index < questionControllers.length) {
        questionControllers[index].dispose();
        questionControllers.removeAt(index);
      }
      questionCount--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "New Survey",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              // الأكشن عند الضغط على الإشعارات
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFDE4D7),
              Color(0xFFFAD2E1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Untitled Form",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: questionControllers.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Question ${index + 1}",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: questionControllers[index],
                            decoration: InputDecoration(
                              hintText: "Answer text",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () => removeQuestion(index),
                                icon: const Icon(Icons.delete, color: Colors.red),
                              ),
                              IconButton(
                                onPressed: addQuestion,
                                icon: const Icon(Icons.add, color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // الأكشن عند الضغط على زر النشر
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFAD2E1),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Publish"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // الأكشن عند الضغط على زر الحفظ
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFDE4D7),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Save"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}