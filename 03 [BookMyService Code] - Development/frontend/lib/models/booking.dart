import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:frontend/models/service_provider.dart';
import 'package:frontend/models/user.dart';

class Booking {
  Booking({
    required this.bookingDate,
    required this.endTime,
    required this.location,
    required this.price,
    required this.requirement,
    required this.serviceDate,
    required this.startTime,
    required this.serviceProviderID,
    required this.userID,
  });

  final DateTime serviceDate;
  final DateTime bookingDate;
  final Time startTime;
  final Time endTime;

  final String location;
  final String requirement;
  final double price;

  final User userID;
  final ServiceProvider serviceProviderID;
}
