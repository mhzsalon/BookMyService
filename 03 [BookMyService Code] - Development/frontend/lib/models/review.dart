import 'package:frontend/models/service_provider.dart';
import 'package:frontend/models/user.dart';

class Review {
  Review(
      {required this.comment,
      required this.serviceProviderID,
      required this.userID});

  final String comment;
  final User userID;
  final ServiceProvider serviceProviderID;
}
