import 'package:flutter/material.dart';
import 'package:loginproject/signin_screen.dart';
import 'user_profile.dart'; // Import the user profile page

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();

  void sendOTP() {
    String phoneNumber = _phoneNumberController.text;
    print('Sending OTP to: $phoneNumber');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OTPVerificationScreen(phoneNumber: phoneNumber),
      ),
    );
  }

  void navigateToUserProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserProfileScreen(), // Navigate to the user profile page
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SigninScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "To move further, please enter your phone number:",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (_phoneNumberController.text.isNotEmpty) {
                  sendOTP();
                } else {
                  // Handle empty phone number field
                  // You can show a snackbar or error message here
                }
              },
              child: Text('Send OTP'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                navigateToUserProfile(); // Open the user profile page
              },
              child: Text('About Me'), // Add the "About Me" button
            ),
          ],
        ),
      ),
    );
  }
}

class OTPVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  OTPVerificationScreen({required this.phoneNumber});

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  String otp = "123456"; // Simulated OTP (Replace this with real OTP logic)

  void verifyOTP() {
    String enteredOTP = _otpController.text;
    if (enteredOTP == otp) {
      // OTP is valid, perform further actions
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('OTP Verification Successful'),
            content: Text('You are now verified and can proceed.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Add code to navigate to the next screen or perform actions
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Invalid OTP
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('OTP Verification Failed'),
            content: Text('The entered OTP is incorrect. Please try again.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Enter the OTP sent to ${widget.phoneNumber}:",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'OTP'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the OTP';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (_otpController.text.isNotEmpty) {
                  verifyOTP();
                } else {
                  // Handle empty OTP field
                  // You can show a snackbar or error message here
                }
              },
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}


