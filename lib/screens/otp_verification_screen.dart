import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dashboard_screen.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String verificationId;

  OTPVerificationScreen({required this.verificationId});

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final _otpController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _verifyOTP() async {
    String otp = _otpController.text.trim();
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: otp,
    );

    try {
      await _auth.signInWithCredential(credential);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    } catch (e) {
      print('OTP Verification Failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Enter Your OTP',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Make the text bold
            fontFamily: 'Noto', // Use the Noto font
          ),
        ),
        backgroundColor: Color(0xFFFFC107), // Dark yellow color
      ),
      body: Column(
        children: [
          // Upper half with the image
          Container(
            height: screenHeight * 0.5, // Set height to 50% of screen height
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              'assets/images/otp_screen.jpg', // Update with your image path
              fit: BoxFit.cover, // Use BoxFit.cover to fill the space
            ),
          ),
          // Lower half with OTP input and button
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _otpController,
                    decoration: InputDecoration(
                      labelText: 'Enter OTP',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _verifyOTP,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                      child: Text('Verify OTP', style: TextStyle(fontSize: 16)),
                    ),
                    style: ElevatedButton.styleFrom(
                     backgroundColor: Color(0xFFFFC107), // Background color of the button
                      minimumSize: Size(double.infinity, 50), // Full width button
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
