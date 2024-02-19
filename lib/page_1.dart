import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'activity_provider.dart';

// //=================================================>>>>
// //================================================ Provider ====>>>>
// // Represents an activity fetched from the API
// class Activity {
//   final String activity;

//   Activity({required this.activity});

//   // Factory method to create an Activity object from JSON data
//   factory Activity.fromJson(Map<String, dynamic> json) {
//     return Activity(
//       activity: json['activity'],
//     );
//   }
// }

// //===========================================================>>>>

// class ActivityProvider extends ChangeNotifier {
//   final List<Activity> _activities = [];
//   bool _activitiesFetched = false;

//   List<Activity> get activities => _activities;

//   //============ Main Bored API fetching start ===>>>>>
//   Future<void> fetchActivities() async {
//     if (!_activitiesFetched) {
//       for (int i = 0; i < 5; i++) {
//         final response =
//             await http.get(Uri.parse('https://www.boredapi.com/api/activity/'));

//         if (response.statusCode == 200) {
//           final jsonData = json.decode(response.body);
//           _activities.add(Activity.fromJson(jsonData));
//         } else {
//           throw Exception('Failed to load activities');
//         }
//       }
//       _activitiesFetched = true;
//       notifyListeners();
//     }
//   }
//   //============ Main Bored API fetching end ===>>>>>

//   //=========== Adding data to firebase database - start===>>>>
//   final String firebaseUrl =
//       'https://fir-database-8ba40-default-rtdb.firebaseio.com/';

//   Future<void> _addToFirebase(String key, String value) async {
//     try {
//       await Future.delayed(
//           Duration.zero); // Delay to allow proper widget initialization
//       final response = await http.post(
//         Uri.parse('$firebaseUrl$key.json'),
//         body: jsonEncode(value),
//       );

//       if (response.statusCode != 200) {
//         throw Exception('Failed to add data to Firebase: ${response.body}');
//       }
//     } catch (error) {
//       print('Failed to add data to Firebase: $error');
//     }
//   } //Future
//   //=========== Adding data to firebase database - end===>>>>

// // =============== Function ========>>>>>
//   // Method to fetch activities again
//   Future<void> refreshActivities() async {
//     _activitiesFetched = false; // Reset the flag
//     await fetchActivities(); // Fetch activities again
//   }

//   //Implementing Page_2 sending data activity!
//   List<Activity> _selectedActivities = [];

//   List<Activity> get selectedActivities => _selectedActivities;

//   void addsetSelectedActivity(Activity activity) {
//     _selectedActivities.add(activity);
//     notifyListeners();
//   }

//   //Implementing Delete Activities
//   void deleteActivity(activity) {
//     _selectedActivities.remove(activity);
//     notifyListeners();
//   }

//   void deleteAllActivities() {
//     _selectedActivities.clear();
//     notifyListeners();
//   }
// }

//================================================= Main Page_1 Scaffold Widget start ===>>>>

class Page_1 extends StatefulWidget {
  const Page_1({
    super.key,
  });

  @override
  State<Page_1> createState() => _Page_1State();
}

//==========================================>>>>

class _Page_1State extends State<Page_1> {
  @override
  void initState() {
    super.initState();
    // Fetch activities when the page initializes
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
                final activities = activityProvider.activities;
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
                          onPressed: () async {
                            // Get the key and activity from the activities list
                            final key =
                                's1'; // You need to define your key here
                            final activity =
                                activityProvider.activities[index].activity;
                            // Add your logic for the first IconButton
                            await activityProvider.addToFirebase(
                                'key', 'activity');
                          },
                          icon: Icon(Icons.favorite),
                        ),
                        IconButton(
                          onPressed: () {
                            // Pass the selected activity to Page_2
                            activityProvider
                                .addsetSelectedActivity(activities[index]);
                            // Navigate to Page_2
                            Navigator.pushNamed(context, '/page2');
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
              // Refresh activities when FloatingActionButton is pressed
              Provider.of<ActivityProvider>(context, listen: false)
                  .refreshActivities();
            },
            child: Icon(Icons.refresh),
          ),
        );
      }, // builder
    );
  }
}
