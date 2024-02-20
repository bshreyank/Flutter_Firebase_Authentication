import 'dart:convert';
import 'package:complete/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:cloud_firestore/cloud_firestore.dart';

//================================================ Provider ====>>>>

class ActivityProvider extends ChangeNotifier {
  final List<Activity> _activities = [];
  bool _activitiesFetched = false;
  List<Activity> get activities => _activities;

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
  Future<void> refreshActivities() async {
    _activitiesFetched = false; // Reset the flag
    await fetchActivities(); // Fetch activities again
  }

  //Implementing Page_2 sending data activity!
  List<Activity> _selectedActivities = [];

  List<Activity> get selectedActivities => _selectedActivities;

  void addsetSelectedActivity(Activity activity) {
    _selectedActivities.add(activity);
    notifyListeners();
  }

  //Implementing Delete Activities
  void deleteActivity(activity) {
    _selectedActivities.remove(activity);
    notifyListeners();
  }

  void deleteAllActivities() {
    _selectedActivities.clear();
    notifyListeners();
  }
}

//================================================= Main Page_1 Scaffold Widget start ===>>>>
