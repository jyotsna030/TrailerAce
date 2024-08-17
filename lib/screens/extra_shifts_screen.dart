import 'package:flutter/material.dart';

class ExtraShiftsScreen extends StatefulWidget {
  @override
  _ExtraShiftsScreenState createState() => _ExtraShiftsScreenState();
}

class _ExtraShiftsScreenState extends State<ExtraShiftsScreen> {
  // A list to track whether each shift is accepted
  List<bool> _acceptedShifts = List<bool>.filled(5, false); // Change the size based on your shift count

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Extra Shifts'),
        backgroundColor: Color(0xFFFFC107), // Dark grey app bar color
      ),
      body: Container(
        color: Colors.grey[200], // Light grey background color
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildShiftTile(0, 'Extra Shift 1', 'Store B', '6:00 PM - 10:00 PM', 'August 17, 2024'),
            SizedBox(height: 10),
            _buildShiftTile(1, 'Extra Shift 2', 'Store C', '11:00 PM - 3:00 AM', 'August 18, 2024'),
            SizedBox(height: 10),
            _buildShiftTile(2, 'Extra Shift 3', 'Store A', '9:00 AM - 1:00 PM', 'August 19, 2024'),
            SizedBox(height: 10),
            _buildShiftTile(3, 'Extra Shift 4', 'Store D', '2:00 PM - 6:00 PM', 'August 20, 2024'),
            SizedBox(height: 10),
            _buildShiftTile(4, 'Extra Shift 5', 'Store E', '5:00 PM - 9:00 PM', 'August 21, 2024'),
            // Add more shifts as needed
          ],
        ),
      ),
    );
  }

  Widget _buildShiftTile(int index, String title, String location, String timing, String date) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text('Location: $location'),
                Text('Timing: $timing'),
                Text('Date: $date'),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _acceptedShifts[index] = true; // Mark this shift as accepted
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _acceptedShifts[index] ? Colors.green : Color(0xFFFFC107), // Change color based on acceptance
                foregroundColor: Colors.black, // Black text color
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                _acceptedShifts[index] ? 'Shift Accepted' : 'Accept Shift',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
