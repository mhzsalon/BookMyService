class User {
  User(
      {required this.name,
      required this.id,
      required this.email,
      required this.location,
      required this.avatar,
      required this.phone,
      required this.userType});

  final String id;
  final String name;
  final String email;
  final String location;
  final String phone;
  final String userType;
  final String avatar;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        name: json['name'],
        id: json['id'],
        email: json['email'],
        location: json['location'],
        avatar: json['avatar'],
        phone: json['phone'],
        userType: json['userType']);
  }
}
