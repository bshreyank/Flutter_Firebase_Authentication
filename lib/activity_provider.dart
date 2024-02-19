import 'dart:convert';
import 'package:flutter/material.dart';
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

//===========================================================>>>>

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
          _activities.add(Activity.fromJson(jsonData));
        } else {
          throw Exception('Failed to load activities');
        }
      }
      _activitiesFetched = true;
      notifyListeners();
    }
  }
  //============ Main Bored API fetching end ===>>>>>

  //=========== Adding data to firebase database - start===>>>>
  final String firebaseUrl =
      'https://fir-database-8ba40-default-rtdb.firebaseio.com/';

  Future<void> addToFirebase(String key, String value) async {
    try {
      await Future.delayed(
          Duration.zero); // Delay to allow proper widget initialization
      final response = await http.post(
        Uri.parse('$firebaseUrl$key.json'),
        body: jsonEncode(value),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to add data to Firebase: ${response.body}');
      }
    } catch (error) {
      print('Failed to add data to Firebase: $error');
    }
  } //Future
  //=========== Adding data to firebase database - end===>>>>

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
