import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'otp_verification_screen.dart';

class PhoneVerificationScreen extends StatefulWidget {
  @override
  _PhoneVerificationScreenState createState() => _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final _phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _sendOTP() async {
    String phone = _phoneController.text.trim();
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print('Verification Failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTPVerificationScreen(verificationId: verificationId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Phone Verification',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Make the text bold
            fontFamily: 'Noto', // Use the Noto font
          ),
        ),
        backgroundColor: Color(0xFFFFC107), // Dark yellow color
      ),
      body: Column(
        children: [
          // Top half for the GIF
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                'assets/images/phone.gif', // Replace with your GIF path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Bottom half for the text and button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Enter your phone number',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _sendOTP,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFC107), // Background color
                    padding: EdgeInsets.symmetric(vertical: 16),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  child: Text('Send OTP'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
