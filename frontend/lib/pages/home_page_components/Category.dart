import 'package:flutter/material.dart';
import 'package:frontend/pages/registration_forms/service_provider.dart';

class Categories extends StatelessWidget {
  Categories({super.key});

  final PageController controller = PageController();

  List<String> _service = [
    'Cleaner',
    'Carpenter',
    'Babysitter',
    'Painter',
    'Electrician',
    'Elderly care',
    'Plumber',
  ];

  var _serviceIcons = [
    Icons.cleaning_services_rounded,
    Icons.carpenter_rounded,
    Icons.baby_changing_station_rounded,
    Icons.format_paint_rounded,
    Icons.electrical_services_rounded,
    Icons.elderly_rounded,
    Icons.plumbing,
  ];


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.only(left: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Categories",
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),

          Scrollbar(
            radius: Radius.circular(10),
            thickness: 5,
            child: Container(
              width: 350,
              margin: EdgeInsets.only(bottom: 15),
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _service.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      print("tapped");
                      PageView.builder(
                        itemBuilder: (context, index) {
                          return PageView(
                            controller: controller,
                            children: [Center(child: Text("first page"))],
                          );
                        },
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 27, top: 15, bottom: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            child: Icon(_serviceIcons[index],
                                color: Colors.orangeAccent, size: 28),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color.fromRGBO(255, 172, 64, 0.204),
                            ),
                          ),
                          Text(
                            _service[index],
                            style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // Container(
          //   color: Colors.blue,
          //   // width: 360,
          //   height: 100,
          //   child:
          // ),
        ],
      ),
    );
  }
}
