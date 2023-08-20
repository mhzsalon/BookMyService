// ignore_for_file: constant_identifier_names, must_be_immutable

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Services/CallAPI.dart';
import 'package:frontend/Services/notification_services.dart';
import 'package:http/http.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

enum PaymentType { Cash_on_hand, Online_payment }

class confirmBooking extends StatefulWidget {
  var uID;
  var price;
  var totalHours;
  var usertype;
  var name;
  var mapData;
  var length;
  var service;
  confirmBooking(
      {super.key,
      this.uID,
      this.price,
      this.totalHours,
      this.name,
      this.usertype,
      this.mapData,
      this.length,
      this.service});

  @override
  State<confirmBooking> createState() => _confirmBookingState();
}

class _confirmBookingState extends State<confirmBooking> {
  PaymentType? _paymentType = PaymentType.Cash_on_hand;

  NotificationServices _notificationServices = NotificationServices();

  String? bID;
  var booking_date;
  var start_time;
  var end_time;
  var location;
  var totalPrice;
  var price;

  CallApi obj = CallApi();

  addPaymentDetail(String id, String paymentType) async {
    print(totalPrice);
    try {
      Response paymentRes = await post(
        Uri.parse("${obj.url}/service/payment/"),
        body: {
          'uID': id.toString(),
          'booking_id': bID.toString(),
          'payment_mode': paymentType.toString(),
          'amount': totalPrice.toString(),
        },
      );
      print("ap");
      if (paymentRes.statusCode == 200) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          headerAnimationLoop: false,
          animType: AnimType.bottomSlide,
          title: 'Success',
          desc: 'Booking Confirmed',
          buttonsTextStyle: const TextStyle(color: Colors.black),
          showCloseIcon: true,
          btnOkOnPress: () {
            Navigator.pop(context);
          },
        ).show();
        _notificationServices.getDeviceToken().then((value) async {
          var data = {
            'to':
                'eeP_6I7VR9u1JGdIkoYPfU:APA91bG9o0KXwADpVw_txor6C-j8r_9xcS58m16rXPFJzU2FOz1me_sJ2t5t5XJg1TE3mzQ_Q6jSsCxkRnt138BEl1aDWpeKV_Ax8uUoB0kCVngkhPdLQ-idU-SkQf1pSCw9WQ_e5bNt',
            'priority': 'high',
            'notification': {
              'title': 'Booking',
              'body': 'Your booking is successfull.',
            },
            'data': {
              'type': 'msg',
              'id': bID.toString(),
            }
          };
          await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
              body: jsonEncode(data),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization':
                    'key=AAAAngiBwRQ:APA91bHYgQPSdbM_itfVe1Bl-mmMkZVywXRZJS8e1kvwgmhC8zQGM-glbCYOwHfQKSu8CcJbW0NFOoBmlLK34SIIsYDHzWIEpUNiD5n7GN8QluydWC87WFZ7B4Mzz1AYY49Zg_xE2Fke',
              });
        });
      }
    } catch (e) {
      return e;
    }
  }

  getBookingDetails() async {
    try {
      Response res = await get(Uri.parse(obj.url + "/booking/book-service/"));

      if (res.statusCode == 200) {
        var details = jsonDecode(res.body.toString());
        print(details);
        setState(() {
          bID = details['id'].toString();
          booking_date = details['serviceDate'];
          location = details['location'];
          totalPrice = details['price'];
          start_time = details['start_time'];
          end_time = details['end_time'];
        });
      }
    } catch (e) {
      return e;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getBookingDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String price = widget.price.toString();
    String hrs = widget.totalHours.toString();
    // ...
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 68,
        title: const Padding(
          padding: EdgeInsets.only(left: 15, top: 4),
          child: Text(
            "Booking Confirmation",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                letterSpacing: 0.5),
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xffF2861E),
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          //Payment Options
          Container(
            height: 270,
            margin: const EdgeInsets.only(top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 25, bottom: 5, left: 30),
                  child: const Text(
                    "Payment options:",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Card(
                  color: _paymentType == PaymentType.Cash_on_hand
                      ? const Color(0xffF2861E)
                      : const Color(0xffF4F0F0),
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  elevation: _paymentType == PaymentType.Cash_on_hand ? 3 : 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SizedBox(
                    height: 90,
                    child: Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 30,
                        ),
                        Icon(
                          Icons.payments_outlined,
                          color: _paymentType == PaymentType.Cash_on_hand
                              ? Colors.white
                              : const Color(0xff0DB53C),
                          size: 35,
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Text(
                          "Cash on hand",
                          style: TextStyle(
                            color: _paymentType == PaymentType.Cash_on_hand
                                ? Colors.white
                                : Colors.black54,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(
                          width: 60,
                        ),
                        Radio<PaymentType>(
                            activeColor: Colors.white,
                            value: PaymentType.Cash_on_hand,
                            groupValue: _paymentType,
                            onChanged: ((val) {
                              setState(() {
                                _paymentType = val;
                              });
                            }))
                      ],
                    ),
                  ),
                ),
                Card(
                  color: _paymentType == PaymentType.Online_payment
                      ? const Color(0xffF2861E)
                      : const Color(0xffF4F0F0),
                  margin:
                      const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                  elevation: _paymentType == PaymentType.Online_payment ? 3 : 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SizedBox(
                    height: 90,
                    child: Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 30,
                        ),
                        Icon(
                          Icons.payment_outlined,
                          color: _paymentType == PaymentType.Online_payment
                              ? Colors.white
                              : const Color(0xff0DB53C),
                          size: 35,
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Text(
                          "Online Payment",
                          style: TextStyle(
                            color: _paymentType == PaymentType.Online_payment
                                ? Colors.white
                                : Colors.black54,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Radio<PaymentType>(
                            activeColor: Colors.white,
                            value: PaymentType.Online_payment,
                            groupValue: _paymentType,
                            onChanged: ((val) {
                              setState(() {
                                _paymentType = val;
                              });
                            }))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Booking details
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 50, left: 30),
                  child: const Text(
                    "Booking Details",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 210,
                  padding: const EdgeInsets.only(left: 25, top: 35),
                  margin: const EdgeInsets.only(left: 30, right: 30, top: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xffF4F0F0),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const Text(
                            "Date and Time: ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black45,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            "$booking_date - $start_time",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          const Text(
                            "Location: ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black45,
                            ),
                          ),
                          const SizedBox(
                            width: 55,
                          ),
                          Text(
                            location.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          const Text(
                            "Price: ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black45,
                            ),
                          ),
                          const SizedBox(
                            width: 80,
                          ),
                          Text(
                            "Rs. $price/hrs",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          const Text(
                            "Total hours: ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black45,
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          Text(
                            "$hrs hrs",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: <Widget>[
                          const Text(
                            "Total Price: ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black45,
                            ),
                          ),
                          const SizedBox(
                            width: 42,
                          ),
                          Text(
                            "Rs. $totalPrice",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          //Confiramtion Button
          Container(
            margin: const EdgeInsets.only(top: 50),
            padding: const EdgeInsets.only(left: 5, right: 8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xffF2861E),
                  minimumSize: const Size(280, 55)),
              onPressed: () {
                _paymentType == PaymentType.Online_payment
                    ? payWithKhaltiInApp()
                    : addPaymentDetail(widget.uID.toString(), "Cash");

                _notificationServices.getDeviceToken().then(
                  (value) async {
                    var data = {
                      'to':
                          'dTa8s_OnQqaTJI_7fol_K0:APA91bFTEWO338ET79Segplqk_kX8zpP35YMluMrFsL7PGUxFxv9gZxqdDHAqv5piUhPTnNxeRhcum_3JdddWtRLhPWwhOYa8ajBbN7J5CcAPe0l0lo70_I6nYSB-unRAu-pnljpSkUK',
                      'priority': 'high',
                      'notification': {
                        'title': 'Booking',
                        'body': 'You have been booked.',
                      },
                      'data': {
                        'type': 'msg',
                        'id': bID.toString(),
                      }
                    };
                    await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
                        body: jsonEncode(data),
                        headers: {
                          'Content-Type': 'application/json; charset=UTF-8',
                          'Authorization':
                              'key=AAAAngiBwRQ:APA91bHYgQPSdbM_itfVe1Bl-mmMkZVywXRZJS8e1kvwgmhC8zQGM-glbCYOwHfQKSu8CcJbW0NFOoBmlLK34SIIsYDHzWIEpUNiD5n7GN8QluydWC87WFZ7B4Mzz1AYY49Zg_xE2Fke',
                        });
                  },
                );
              },
              child: const Text(
                "Confirm Booking",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  payWithKhaltiInApp() {
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
          amount: 1000, productIdentity: "Service", productName: "ServiceType"),
      preferences: [
        PaymentPreference.khalti,
      ],
      onSuccess: onSuccess,
      onFailure: onFailure,
      onCancel: onCancel,
    );
  }

  void onSuccess(PaymentSuccessModel success) {
    addPaymentDetail(widget.uID.toString(), "Online");
    _notificationServices.getDeviceToken().then(
      (value) async {
        var data = {
          'to':
              'dhWzsSmRRJmuXi3Nurk2Yt:APA91bHnz1LHlFsTu9TMheOAdoZCei6_zfWtV6zCCQyGfLLB8tdkBiK9V_49DgBMONehiYYYqq5C3sy8x9fGIwXxcNWUvGfhOAfK9YcRPi7MHGpkeWkfndCfIvY2jH83O0_AzI0UxSQ1',
          'priority': 'high',
          'notification': {
            'title': 'Booking',
            'body': 'You have been booked.',
          },
          'data': {
            'type': 'msg',
            'id': bID.toString(),
          }
        };
        await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
            body: jsonEncode(data),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization':
                  'key=AAAAngiBwRQ:APA91bHYgQPSdbM_itfVe1Bl-mmMkZVywXRZJS8e1kvwgmhC8zQGM-glbCYOwHfQKSu8CcJbW0NFOoBmlLK34SIIsYDHzWIEpUNiD5n7GN8QluydWC87WFZ7B4Mzz1AYY49Zg_xE2Fke',
            });
      },
    );
  }

  void onFailure(PaymentFailureModel faliure) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Error',
      desc: 'Payment Failed!',
      buttonsTextStyle: const TextStyle(color: Colors.black),
      showCloseIcon: true,
      btnOkOnPress: () {
        setState(() {
          Navigator.pop(context);
        });
      },
    ).show();
  }

  void onCancel() {
    debugPrint("cancled");
    const cancelsnackBar = SnackBar(
      content: Text("Payment Canceled!"),
    );
    ScaffoldMessenger.of(context).showSnackBar(cancelsnackBar);
  }
}
