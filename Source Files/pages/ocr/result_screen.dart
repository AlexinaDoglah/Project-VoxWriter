//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

//class ResultScreen extends StatelessWidget {
  //final String text;

  //const ResultScreen({super.key, required this.text});

  //@override
  //Widget build(BuildContext context) => Scaffold(
    //appBar: AppBar(
     // title: const Text('Result'),
    //),
    //body: SingleChildScrollView(
      //reverse: true,
      //child: Text(text),

    //),
  //);
//}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResultScreen extends StatelessWidget {
  final String text;

  const ResultScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Result'),
    ),
    body: SingleChildScrollView(
      reverse: true,
      child: Column(
        children: [
          Text(text,
      style: const TextStyle(
      fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.bold
      ),
          ),
          const SizedBox(height: 20), // Add some space
          Center(
            child: ElevatedButton(
              child: const Text('Copy Text'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: text));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Text copied to clipboard')),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
