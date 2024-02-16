import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

//=================================================>>>>
//================================================ Provider ====>>>>
// Represents an activity fetched from the API
class Activity {
  final String activity;

  Activity({required this.activity});

  // Factory method to create an Activity object from JSON data
  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      activity: json['activity'],
    );
  }
}

class ActivityProvider extends ChangeNotifier {
  final List<Activity> _activities = [];

  // Getter to access the list of activities
  List<Activity> get activities => _activities;

  get list => null;

  // Method to fetch activities from the API
  Future<void> fetchActivities() async {
    for (int i = 0; i < 5; i++) {
      final response = await http.get(
          Uri.parse('https://www.boredapi.com/api/activity/?participants=1'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        _activities.add(Activity.fromJson(jsonData));
      } else {
        throw Exception('Failed to load activities');
      }
    }
    notifyListeners(); // Notify listeners (widgets) that data has changed
  }

  //come to this later
  void handleDeleteActivity(e) {}
  //come to this later
  void handleDeleteAll() {}
}

//=================================================>>>>

class Page_1 extends StatefulWidget {
  const Page_1({
    super.key,
  });

  @override
  State<Page_1> createState() => _Page_1State();
}

class _Page_1State extends State<Page_1> {
  @override
  void initState() {
    super.initState();
    // Fetch activities when the home page is initialized
    Provider.of<ActivityProvider>(context, listen: false).fetchActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ActivityProvider>(
      builder: (context, activityProvider, _) {
        return Scaffold(
          body: Center(
            child: Consumer<ActivityProvider>(
              builder: (context, activityProvider, _) {
                final activities = activityProvider
                    .activities; // Get the list of activities from the provider
                return ListView.builder(
                  itemCount: activities.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text(activities[index].activity),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Add your logic for the first IconButton
                          },
                          icon: Icon(Icons.favorite),
                        ),
                        IconButton(
                          onPressed: () {
                            // Add your logic for the second IconButton
                          },
                          icon: Icon(Icons.add),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Fetch activities when the refresh button is pressed
              Provider.of<ActivityProvider>(context, listen: false)
                  .fetchActivities();
            },
            child: Icon(Icons.refresh),
          ),
        );
      }, // builder
    );
  }
}
