import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EndShiftScreen extends StatefulWidget {
  @override
  _EndShiftScreenState createState() => _EndShiftScreenState();
}

class _EndShiftScreenState extends State<EndShiftScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _endShift() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Shift Ended Successfully')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      print('End Shift Failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('End Shift Failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('End Shift'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _endShift,
              child: Text('Confirm End Shift'),
            ),
          ],
        ),
      ),
    );
  }
}
