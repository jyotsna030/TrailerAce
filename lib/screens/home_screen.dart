import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'end_shift_screen.dart';
import 'extra_shifts_screen.dart';
import 'real_time_chat_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController? _mapController;
  final User? user = FirebaseAuth.instance.currentUser;

  // Dummy location for prototype
  LatLng _dummyLocation = LatLng(37.7749, -122.4194); // San Francisco coordinates

  // Variables to hold driver details
  String driverName = '';
  String trailerNumber = 'XYZ123';
  String shiftTiming = '9:00 AM - 5:00 PM';
  String route = 'Warehouse to Store A';

  @override
  void initState() {
    super.initState();
    _getDriverDetails();
  }

  // Fetch driver details from Firestore
  void _getDriverDetails() async {
    if (user != null) {
      DocumentSnapshot driverDoc = await FirebaseFirestore.instance
          .collection('drivers')
          .doc(user!.uid)
          .get();

      setState(() {
        driverName = driverDoc['name'] ?? 'Driver';
        trailerNumber = driverDoc['trailerNumber'] ?? 'XYZ123';
        shiftTiming = driverDoc['shiftTiming'] ?? '9:00 AM - 5:00 PM';
        route = driverDoc['route'] ?? 'Warehouse to Store A';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: <Widget>[
      UserAccountsDrawerHeader(
        accountName: Text(driverName),
        accountEmail: Text(user?.email ?? ''),
        currentAccountPicture: CircleAvatar(
          backgroundColor: Colors.transparent, // Set to transparent if using backgroundImage
          backgroundImage: AssetImage('assets/images/driver.jpg'), // Replace with your image path
          child: driverName.isEmpty
              ? null
              : Text(
                  driverName[0],
                  style: TextStyle(fontSize: 40.0, color: Colors.white),
                ),
        ),
      ),
            ListTile(
              leading: Icon(Icons.work),
              title: Text('Extra Shifts'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExtraShiftsScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('Chat with Support'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RealTimeChatScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                // Navigate to Profile screen
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                // Navigate to login screen
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display driver details
            Text(
              'Welcome, $driverName',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Trailer Number:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(trailerNumber),
            SizedBox(height: 10),
            Text(
              'Shift Timing:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(shiftTiming),
            SizedBox(height: 10),
            Text(
              'Route:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(route),
            SizedBox(height: 20),
            // Display Google Map with image overlay
            Stack(
              children: [
                Container(
                  height: 250, // Size of the map
                  width: double.infinity, // Make the map container take the full width
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _dummyLocation,
                      zoom: 15,
                    ),
                    myLocationEnabled: false,
                    onMapCreated: (GoogleMapController controller) {
                      _mapController = controller;
                    },
                    markers: {
                      Marker(
                        markerId: MarkerId('dummyLocation'),
                        position: _dummyLocation,
                        infoWindow: InfoWindow(title: "Current Location"),
                      ),
                    },
                  ),
                ),
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/map.png', // Path to your image
                    fit: BoxFit.cover, // Make the image cover the entire area
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Button to end shift
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                 backgroundColor: Color(0xFFFFC107), // Background color of the button
                foregroundColor: Colors.black,  // Text color
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EndShiftScreen()),
                );
              },
              child: Center(child: Text('End Shift')),
            ),
          ],
        ),
      ),
    );
  }
}
