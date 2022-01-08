import 'package:flutter/material.dart';
import 'package:jseen/jseen_tree.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSeen Demo',
      theme: ThemeData.dark(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jseen Demo'),
      ),
      body: JSeenTree(json: jsonString),
    );
  }
}

const jsonString = """{
    "name": "Bob Pillage",
    "occupation": "Software Developer",
    "age": 37,
    "religion": null,
    "hobbies": [
        "Football",
        "Climbing",
        "Fishing",
        "Working out"
    ],
    "education": [
        {
            "institution": "Harvard",
            "yearsCompleted": 8,
            "diploma": "Masters in Computer Science",
            "gpa": 3.8
        },
        {
            "institution": "MIT",
            "yearsCompleted": 3,
            "diploma": "Bachelor in Economics",
            "gpa": 4.0
        }
    ],
    "married": true,
    "address": {
        "street": "453 Golden Lane",
        "city": "PreciousVille",
        "state": "Florida",
        "zipcode": 935201
    }
}""";
