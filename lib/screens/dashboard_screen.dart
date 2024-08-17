import 'package:flutter/material.dart';
import 'registration_screen.dart';
import 'login_screen.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Make the text bold
            fontFamily: 'Noto', // Use the Noto font
          ),
        ),
        backgroundColor: Color(0xFFFFC107), // Dark yellow color
      ),
      body: Column(
        children: [
          // Upper half of the screen with image and button
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.yellow, width: 2.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/images/login_icon.png',
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // Button background color
                        foregroundColor: Colors.black, // Dark text color for visibility
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        minimumSize: Size(double.infinity, 50), // Full width
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      },
                      child: Text('Login for the Day', style: TextStyle(fontSize: 20)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Lower half of the screen with image and button
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/images/register_icon.png',
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // Button background color
                        foregroundColor: Colors.black, // Dark text color for visibility
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        minimumSize: Size(double.infinity, 50), // Full width
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegistrationScreen()),
                        );
                      },
                      child: Text('Register', style: TextStyle(fontSize: 20)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
