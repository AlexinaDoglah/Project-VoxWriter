import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:voxwritter/pages/note_app/screen/note_home_screen.dart';
import 'package:voxwritter/pages/speech_text.dart';
import 'package:voxwritter/pages/ocr/main_screen.dart';
import 'package:voxwritter/translator/home_screen.dart';
import '../components/my_button.dart';
import 'package:voxwritter/pages/chatbot/germini_ai.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});
  final user = FirebaseAuth.instance.currentUser;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white54,//[900],
        body: SafeArea(
          child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //welcome text
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Hello! Welcome,',
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                          const SizedBox(height: 8),
                          Text(" ${user?.email!}",
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    //notification
                    GestureDetector(
                      onTap: () {Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=> GeminiChatBot()));
                        },
                      child: Container(
                        decoration: BoxDecoration(color: Colors.green,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Icon(
                          Icons.android,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                //search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: const Row(
                    children: [
                      Icon(Icons.note,
                        color: Colors.white54,
                      ),
                      SizedBox(width: 5),
                      Text('VOXwritter',
                        style: TextStyle(
                            color: Colors.white38
                        ),
                      ),
                    ],
                  ),
                ),


                IconButton(
                  onPressed: signUserOut,
                  icon: const Icon(Icons.logout),
                ),

                const SizedBox(height: 10),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      color: Colors.black12,
                      child: Center(
                        child: Column(
                            children: [

                              const Row(

                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 20),
                                  Text(
                                    "Voxwritter",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white54,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(Icons.more_horiz_rounded,
                                color: Colors.green[200],
                              ),


                              //listview  options

                              Expanded(
                                child: ListView(
                                  children: [
                                    const SizedBox(height: 15),
                                    Text(
                                      "Speech Recognition:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.green[300],
                                      ),
                                    ),
                                    MyButton(
                                      text: "Speech to Text",
                                      onTap: () {Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context)=> SpeechScreen()));
                                      }
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      "Translator:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.green[300],
                                      ),
                                    ),

                                    const SizedBox(height: 15),
                                    MyButton(
                                      text: "Text Translator",
                                      onTap: () {Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context)=> HomeScreen()));},
                                    ),

                                    const SizedBox(height: 15),
                                    Text(
                                      "OCR:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.green[300],
                                      ),
                                    ),
                                    MyButton(
                                      text: "Text Recognition",
                                      onTap: () {Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context)=>const MainScreen()));},
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      "Other Functions:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.green[300],
                                      ),
                                    ),

                                    MyButton(
                                      text: "Notes",
                                      onTap: () {Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context)=>const NotesHomeScreen()));},
                                    ),

                                  ],


                                ),
                              ),
                            ]


                        ),

                      ),
                    ),
                  ),
                ),
              ]
          )
      ),
    );
  }
}
