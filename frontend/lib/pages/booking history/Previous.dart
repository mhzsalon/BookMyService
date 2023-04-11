import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PreviousBookings extends StatefulWidget {
  const PreviousBookings({super.key});

  @override
  State<PreviousBookings> createState() => _PreviousBookingsState();
}

class _PreviousBookingsState extends State<PreviousBookings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('hello'),
      ),
    );
  }
}
