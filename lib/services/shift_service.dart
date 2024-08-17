import 'package:cloud_firestore/cloud_firestore.dart';

class ShiftService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a new shift
  Future<void> addShift(String driverId, String shiftTime, String route) async {
    try {
      await _firestore.collection('shifts').add({
        'driverId': driverId,
        'shiftTime': shiftTime,
        'route': route,
        'status': 'pending',
      });
    } catch (e) {
      print(e.toString());
    }
  }

  // Update shift status
  Future<void> updateShiftStatus(String shiftId, String status) async {
    try {
      await _firestore.collection('shifts').doc(shiftId).update({
        'status': status,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  // Real-time listener for shift allocation
  Stream<QuerySnapshot> getAvailableShifts() {
    return _firestore.collection('shifts').where('status', isEqualTo: 'pending').snapshots();
  }
}
