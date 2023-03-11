import 'package:flutter/material.dart';
import 'package:frontend/pages/home_page_components/Category.dart';
import 'package:frontend/pages/home_page_components/Offers.dart';
import 'package:frontend/pages/home_page_components/trending.dart';
import 'package:frontend/pages/notification.dart';

class HomePage extends StatefulWidget {
  var userType;
  HomePage({super.key, this.userType});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    String type = widget.userType;
    return Scaffold(
      backgroundColor: Color(0xffEEF1F9),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              top(),
              type == "Clients"?
              search(): Text("Welcome Service Provider"),
              type == "Clients"?
              OfferSlider(): Container(),
              type == "Clients"?
              Categories(): Container(),
              type == "Clients"?
              TrendingSP(): Container(),
            ],
          ),
        ),
      )),
    );
  }

  Widget top() {
    return Container(
      margin: EdgeInsets.only(top: 30, left: 25, right: 25),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 22,
            backgroundImage: AssetImage("images/default-profile.png"),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Mark Tatum",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              Row(
                children: [
                  Text(
                    "Edit",
                    style: TextStyle(
                      color: Color(0xffF2861E),
                      fontSize: 14,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Icon(
                    Icons.edit,
                    color: Color(0xffF2861E),
                    size: 15,
                  )
                ],
              ),
            ],
          ),
          SizedBox(width: 150),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotificationPage()));
            },
            child: Container(
              width: 45,
              height: 45,
              child: Icon(Icons.notifications, color: Colors.white, size: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.orangeAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget search() {
    return GestureDetector(
      onTap: () {
        showSearch(
          context: context,
          delegate: CustomSearchDelegate(),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 25, left: 25, right: 25),
        height: 55,
        decoration: BoxDecoration(
            color: Color.fromARGB(203, 255, 255, 255),
            borderRadius: BorderRadius.circular(15)),
        child: Row(children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.search,
            size: 22,
            color: Colors.black45,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            "Search here",
            style: TextStyle(
              color: Colors.black45,
              fontSize: 18,
            ),
          ),
        ]),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    'Cleaner',
    'Painter',
    'Carpenter',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var sp_types in searchTerms) {
      if (sp_types.toLowerCase().contains((query.toLowerCase()))) {
        matchQuery.add(sp_types);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: ((context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var sp_types in searchTerms) {
      if (sp_types.toLowerCase().contains((query.toLowerCase()))) {
        matchQuery.add(sp_types);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: ((context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      }),
    );
  }
}
