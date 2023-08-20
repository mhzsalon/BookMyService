import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/service_provider.dart';
import 'package:frontend/models/user.dart';

class SPNotifier extends StateNotifier<List<ServiceProvider>> {
  SPNotifier() : super([]);

  void addSP(User serviceProvider, String id, bool activeStatus,
      String description, String service, double price) {
    final user = ServiceProvider(
        serviceProvider: serviceProvider,
        activeStatus: activeStatus,
        description: description,
        price: price,
        service: service);

    state = [user, ...state];
  }
}

final spProvider = StateNotifierProvider<SPNotifier, List<ServiceProvider>>(
    (ref) => SPNotifier());
