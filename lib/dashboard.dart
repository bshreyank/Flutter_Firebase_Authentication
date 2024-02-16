import 'dart:convert';
import 'package:complete/page_1.dart';
import 'package:complete/page_2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

//=================================================>>>>
//================================================ Provider ====>>>>

class ActivityProvider extends ChangeNotifier {
  String _activity = '';
  List<String> list = [];
  bool isloading = false;

  String get activity => _activity;

  //no need
  get activities => null;

  // bool get isloading => _isloading;

/*
  void add(String activity) {
    list.add(activity);
    notifyListeners();
  }
*/

  void handleDeleteActivity(String activity) {
    list.remove(activity);
    notifyListeners();
  }

  void handleDeleteAll() {
    list.clear();
    notifyListeners();
  }

  Future<void> fetchActivity() async {
    isloading = true;
    notifyListeners();

    final response =
        await http.get(Uri.parse('https://www.boredapi.com/api/activity'));

    isloading = false;
    notifyListeners();

    final jsonData = json.decode(response.body);

    _activity =
        jsonData['activity']; // Use 'this.' to refer to the class member

    list.add(activity);
    notifyListeners();
  }

  void fetchAdditionalActivities() {
    for (int i = 0; i < 5; i++) {
      fetchActivity();
    }
  }
}

//=================================================>>>>

class _dashboardState extends State<dashboard> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    ///==============================Page 1
    Page_1(),

    ///==============================Page 2
    Page_2(),

    ///==============================Page 2 - end
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
