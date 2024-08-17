class Driver {
  final String id;
  final String name;
  final int age;
  final String licenseNumber;
  final String email;

  Driver({required this.id, required this.name, required this.age, required this.licenseNumber, required this.email});

  // Convert a Driver object into a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'licenseNumber': licenseNumber,
      'email': email,
    };
  }

  // Create a Driver object from a map
  factory Driver.fromMap(Map<String, dynamic> map) {
    return Driver(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      licenseNumber: map['licenseNumber'],
      email: map['email'],
    );
  }
}
