import 'package:flutter/material.dart';

enum PaymentType { Cash_on_hand, Online_payment }

class confirmBooking extends StatefulWidget {
  const confirmBooking({super.key});

  @override
  State<confirmBooking> createState() => _confirmBookingState();
}

class _confirmBookingState extends State<confirmBooking> {
  PaymentType? _paymentType = PaymentType.Cash_on_hand;

  @override
  Widget build(BuildContext context) {
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
        foregroundColor: Color(0xffF2861E),
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          //Payment Options
          Container(
            height: 270,
            margin: EdgeInsets.only(top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 25, bottom: 5, left: 30),
                  child: Text(
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
                      ? Color(0xffF2861E)
                      : Color(0xffF4F0F0),
                  margin: EdgeInsets.only(left: 30, right: 30),
                  elevation: _paymentType == PaymentType.Cash_on_hand ? 3 : 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SizedBox(
                    height: 90,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 30,
                        ),
                        Icon(
                          Icons.payments_outlined,
                          color: _paymentType == PaymentType.Cash_on_hand
                              ? Colors.white
                              : Color(0xff0DB53C),
                          size: 35,
                        ),
                        SizedBox(
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
                        SizedBox(
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
                      ? Color(0xffF2861E)
                      : Color(0xffF4F0F0),
                  margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
                  elevation: _paymentType == PaymentType.Online_payment ? 3 : 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SizedBox(
                    height: 90,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 30,
                        ),
                        Icon(
                          Icons.payment_outlined,
                          color: _paymentType == PaymentType.Online_payment
                              ? Colors.white
                              : Color(0xff0DB53C),
                          size: 35,
                        ),
                        SizedBox(
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
                        SizedBox(
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
                  margin: EdgeInsets.only(top: 50, left: 30),
                  child: Text(
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
                  padding: EdgeInsets.only(left: 25, top: 35),
                  margin: EdgeInsets.only(left: 30, right: 30, top: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xffF4F0F0),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "Date and Time: ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black45,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "12 Dec, 2022 - 10:00 am ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Location: ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black45,
                            ),
                          ),
                          SizedBox(
                            width: 55,
                          ),
                          Text(
                            "Sundhara, Lalitpur",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Price: ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black45,
                            ),
                          ),
                          SizedBox(
                            width: 80,
                          ),
                          Text(
                            "Rs. 500/hrs",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Total hours: ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black45,
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            "3 hrs",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Total Price: ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black45,
                            ),
                          ),
                          SizedBox(
                            width: 42,
                          ),
                          Text(
                            "Rs. 1500",
                            style: TextStyle(
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
            margin: EdgeInsets.only(top: 50),
            padding: EdgeInsets.only(left: 5, right: 8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xffF2861E),
                  minimumSize: Size(280, 55)),
              onPressed: () {},
              child: Text(
                "Confirm Booking",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
