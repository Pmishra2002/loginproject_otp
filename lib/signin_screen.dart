import 'package:flutter/material.dart';
import 'package:loginproject/reusable.dart';
import 'package:loginproject/signup_screen.dart';

import 'color_util.dart';
import 'firebase_options.dart';
import 'home_screen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(gradient: LinearGradient
          (colors: [hexStringToColor("CB2B93"),
          hexStringToColor("9546C4"),
          hexStringToColor("5E61F4")],
            begin: Alignment.topCenter, end: Alignment.bottomCenter
        )
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery
                .of(context)
                .size
                .height * 0.2, 50, 150),
            child: Column(
              children: <Widget>[
                logoWidget("assets/myimage.png"),
                SizedBox(
                  height: 30,
                ),
                reusableTextField("Enter user Name", Icons.person_2_outlined, false, _emailTextController
                ),

                SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter password", Icons.lock_outline, true, _emailTextController
                ),

                SizedBox(
                  height: 20,
                ),
                signInSignUpButton(context, true, (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                }),
                SignUpOption()


              ],
            ),
          ),
        ),

      ),
    );
  }

  Row SignUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text ("Don't have account?",
            style: TextStyle(color: Colors.white70)), // Text
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute (builder: (context) => SignUpScreen()));
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),

          ), // Text

        ) // GestureDetector
      ],

    ); // Row

  }

}
// void initializeFirebase() async {
//   try {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//     // Firebase is initialized, you can now use Firebase services.
//     // For example, you can access Firestore, Realtime Database, etc.
//     print('Firebase initialized successfully.');
//   } catch (e) {
//     print('Error initializing Firebase: $e');
//     // Handle initialization error here.
//   }
// }
// }