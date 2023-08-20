import 'package:frontend/models/user.dart';

class ServiceProvider {
  ServiceProvider({
    required this.serviceProvider,
    // required this.email,
    // required this.location,
    // required this.avatar,
    // required this.phone,
    // required this.userType,
    required this.activeStatus,
    required this.description,
    required this.price,
    required this.service,
  });

  // final String name;
  // final String email;
  // final String location;
  // final String phone;
  // final String userType;
  // final String avatar;

  final User serviceProvider;

  // Service providers extra details
  final String service;
  final double price;
  final String description;
  final bool activeStatus;
}
