import 'package:flutter/material.dart';

class OfferSlider extends StatefulWidget {
  const OfferSlider({super.key});

  @override
  State<OfferSlider> createState() => _OfferSliderState();
}

class _OfferSliderState extends State<OfferSlider> {
  List<String> imgList = [
    'images/offer1.png',
    'images/offer2.png',
    'images/offer3.png',
  ];
  int current_index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        SizedBox(
          height: 200,
          width: 400,
          child: PageView.builder(
            onPageChanged: (value) {
              setState(() {
                current_index = value;
              });
            },
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    imgList[index],
                    height: 200,
                    // width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 165),
          child: SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                        color: index == current_index
                            ? Colors.black45
                            : Colors.grey[350],
                        shape: BoxShape.circle,
                      ),
                    ));
              },
            ),
          ),
        ),
      ],
    ));
  }
}
