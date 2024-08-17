class Shift {
  final String id;
  final String driverId;
  final String shiftTime;
  final String route;
  final String status;

  Shift({required this.id, required this.driverId, required this.shiftTime, required this.route, required this.status});

  // Convert a Shift object into a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'driverId': driverId,
      'shiftTime': shiftTime,
      'route': route,
      'status': status,
    };
  }

  // Create a Shift object from a map
  factory Shift.fromMap(Map<String, dynamic> map) {
    return Shift(
      id: map['id'],
      driverId: map['driverId'],
      shiftTime: map['shiftTime'],
      route: map['route'],
      status: map['status'],
    );
  }
}
