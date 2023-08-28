import 'package:flutter/material.dart';

Color scaffoldBgColor = const Color(0xFF343541);
Color cardColor = const Color(0xFF444654);
Color textColor = Colors.white;

const String modelUrl = "https://api.openai.com/v1/models";

List<String> models = [
  "Model 1",
  "Model 2",
  "Model 3",
  "Model 4",
  "Model 5",
  "Model 6",
];

List<DropdownMenuItem<String>> getModelsItem() {
  List<DropdownMenuItem<String>> modelsItems = models.map(
    (String model) {
      return DropdownMenuItem<String>(
        value: model,
        child: Text(
          model,
          style: TextStyle(
            fontSize: 15,
            color: textColor,
          ),
        ),
      );
    },
  ).toList();
  return modelsItems;
}

final chatMessages = [
  {
    "message": "Hello",
    "chatIndex": 0,
  },
  {
    "message": "Hello! How can I assist you today?",
    "chatIndex": 1,
  },
  {
    "message": "Today's date?",
    "chatIndex": 0,
  },
  {
    "message": "26 August",
    "chatIndex": 1,
  },
  {
    "message": "What is java?",
    "chatIndex": 0,
  },
  {
    "message":
        "Java is a general-purpose, high-level programming language that was developed by Sun Microsystems in 1995. It is one of the most popular programming languages for building enterprise-level software, mobile apps, web applications, and embedded systems. Java is designed to be platform-independent, allowing programs written in Java to run on any device or operating system that has a Java Virtual Machine (JVM) installed. It is known for its simplicity, security, and robustness, as well as its vast ecosystem of libraries and frameworks. Java code is compiled into bytecode and executed by the JVM, which translates the bytecode into machine code that can be executed by the underlying hardware.",
    "chatIndex": 1,
  }
];
