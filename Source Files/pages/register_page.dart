import "package:firebase_auth/firebase_auth.dart";
import"package:flutter/material.dart";
import "package:voxwritter/pages/home_page.dart";
import "../../components/my_text_field.dart";
import '../../components/my_button.dart';
import "../../helper/helper_functions.dart";
import 'package:voxwritter/auth/auth.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text controllers
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmpasswordController = TextEditingController();

  //register method
  void registerUser() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) =>
      const Center(
        child: CircularProgressIndicator(),
      ),
    );

    //make sure passwords match
    if (passwordController.text != confirmpasswordController.text) {
      Navigator.pop(context);

      displayMessageToUser("passwords dont match!", context);
    }
    //if passwords dont match
    else {
      //try creating the user
      try {
        //create the user
        UserCredential? userCredential =
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        // pop loading circle
        Navigator.pop(context);
      }
      on FirebaseAuthException catch (e) {
        //pop loading circle
        Navigator.pop(context);

        //display error message
        displayMessageToUser(e.code, context);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).colorScheme.background,
      backgroundColor: Colors.white70,
      body:  Container(
        decoration: BoxDecoration(
        gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.blue,
          Colors.green,
          Colors.blue,
          //Colors.deepPurple,

        ]
    ),
    ),
      child:Center(
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
                  color: Colors.white54//Theme.of(context).colorScheme.secondary,
                  //color: Colors.black45,
                ),
            
                const SizedBox(height: 5),
            
                //app name
                Text(
                    "VOXwritter",
                    style: TextStyle(fontSize: 28)
                ),
            
                const SizedBox(height: 60),
            
                //Username textfield
            
                MyTextField(
                  hintText: "UserName",
                  TextEditingController: usernameController,
                  obscureText: false,
                ),
            
                const SizedBox(height: 10),
            
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
                  TextEditingController: confirmpasswordController,
                  obscureText: true,
                ),
            
                const SizedBox(height: 10),
            
                //password textfield
                MyTextField(
                  hintText: "Confirm Password",
                  TextEditingController: passwordController,
                  obscureText: true,
                ),
            
                const SizedBox(height: 10),
                //sign in register
                MyButton(
                    text: "Register",
                    onTap: registerUser //() {}, //{Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomePage(), builder: (BuildContext context) {  })); },
                ),
            
                //forgot password
                const SizedBox(height: 15),

                //already have an account , login here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "Already have an account?",
                        style: TextStyle(
                            color: Colors.white54//Theme.of(context).colorScheme.secondary
                        )
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                          " Login Here",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )
                      ),
                    )
                  ],
                ),
  ]
          ),
        ),

      ),

    )
    )
    );
  }
}