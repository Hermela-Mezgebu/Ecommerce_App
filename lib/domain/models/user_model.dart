class UserModel {
  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final String phone;
  final String city;

  UserModel({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.city,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstname: json['name']['firstname'],
      lastname: json['name']['lastname'],
      email: json['email'],
      phone: json['phone'],
      city: json['address']['city'],
    );
  }

  String get fullName => '$firstname $lastname';
}