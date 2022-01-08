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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = TextEditingController();
  var json = jsonString;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jseen Demo'),
      ),
      body: Row(
        children: [
          Expanded(
            child: Container(
              // height: double.infinity,
              child: Column(
                children: [
                  Expanded(
                    child: TextField(
                      // maxLines: 30,
                      expands: true,
                      maxLines: null,
                      minLines: null,
                      controller: controller,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          json = controller.text;
                        });
                      },
                      child: Text('Render'),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white)),
              child: JSeenTree(
                json: json,
                key: ValueKey(json.hashCode),
                indent: 20,
              ),
            ),
          ),
        ],
      ),
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
