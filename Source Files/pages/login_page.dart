import"package:flutter/material.dart";
import "package:voxwritter/pages/home_page.dart";
import "../components/my_text_field.dart";
import '../components/my_button.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:voxwritter/auth/auth.dart';
import "../../helper/helper_functions.dart";
import 'package:voxwritter/auth/login_or_register.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //get context => AlertDialog;

  //login method
  void loginUser() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) =>
      const Center(
        child: CircularProgressIndicator(),
      ),
    );


    //try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      //pop loading circle
      if (context.mounted) Navigator.pop(context);
    }
    //display any errors
    on FirebaseAuthException catch (e) {
      // pop loading circle

      Navigator.pop(context);
      displayMessageToUser(e.code, context);
    }
  }


  //@override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).colorScheme.background,
      //backgroundColor: Colors.tealAccent,
      body: Container(
        decoration: BoxDecoration(
        gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.blue,
          Colors.green,
          Colors.blue,
        ]
    ),
    ),

        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //logo
                  Icon(
                    Icons.article,
                    size: 80,
                    //color: Theme.of(context).colorScheme.inversePrimary,
                    color: Colors.white54  //Theme
                        //.of(context)
                        //.colorScheme
                        //.secondary,
                    //color: Colors.black45,
                  ),
        
                  const SizedBox(height: 25),
        
                  //app name
                  Text(
                      "VOXwritter",
                      //color: Colors.purple,
                      style: TextStyle(fontSize: 28)
                  ),
        
                  const SizedBox(height: 60),
        
                  //email textfield
                  MyTextField(
                    hintText: "Email",
                    TextEditingController: emailController,
                    obscureText: false,
                  ),
        
                  const SizedBox(height: 10),
        
                  //password textfield
                  MyTextField(
                    hintText: "Password",
                    TextEditingController: passwordController,
                    obscureText: true,
                  ),
        
                  const SizedBox(height: 10),
        
                  //forgot password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                          "Forgot Password?",
                          style: TextStyle(
                              color: Colors.white54 //Theme
                                  //.of(context)
                                  //.colorScheme
                                 // .secondary
                          )
                      ),
                    ],
                  ),
        
                  const SizedBox(height: 40),
        
                  //sign in button
                  MyButton(
                    text: "LOGIN",
                    onTap: loginUser, //{Navigator.pushReplacement(context,MaterialPageRoute(buider: (context) => HomePage())); },
                  ),
        
                  const SizedBox(height: 15),
        
                  //dont have an account , register her
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          "Don't have an account?",
                          style: TextStyle(
                              color: Colors.white54 //Theme
                                  //.of(context)
                                  //.colorScheme
                                  //.secondary
                          )
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                            "Register Here",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )
                        ),
                      )
                    ],
                  ),
        
                ],
              ),
            ),
          ),
        
        ),
      ),

    );
  }
}
