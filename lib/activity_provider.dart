import 'dart:convert';
import 'package:complete/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//================================================ Provider ====>>>>

class ActivityProvider extends ChangeNotifier {
  final List<Activity> _activities = [];
  bool _activitiesFetched = false;
  List<Activity> get activities => _activities;

  void clearActivity() {
    _activities.clear();
    notifyListeners();
  }

  //============ Main Bored API fetching start ===>>>>>
  Future<void> fetchActivities() async {
    if (!_activitiesFetched) {
      for (int i = 0; i < 5; i++) {
        final response =
            await http.get(Uri.parse('https://www.boredapi.com/api/activity/'));

        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          _activities.add(
            Activity(
              title: jsonData['activity'],
              isLiked: false,
              isSaved: false,
            ),
          );
        } else {
          throw Exception('Failed to load activities');
        }
      }
      _activitiesFetched = true;
      notifyListeners();
    }
  }
  //============ Main Bored API fetching end ===>>>>>

// =============== Function ========>>>>>
  // Method to fetch activities again
  // Future<void> refreshActivities() async {
  //   // _activities.clear();
  //   _activitiesFetched = false; // Reset the flag
  //   await fetchActivities(); // Fetch activities again
  //   notifyListeners();
  // }

  Future<void> refreshActivities() async {
    if (!_activitiesFetched) {
      // Check if activities have been fetched before
      _activitiesFetched =
          true; // Set the flag to true to indicate activities have been fetched
      await fetchActivities(); // Fetch activities only if not fetched before
      notifyListeners();
    }
    notifyListeners();
  }

  //Implementing Page_2 sending data activity!
  //main_needed.txt
}

//============================ Main Page_1 Scaffold Widget start ===>>>>
