import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'activity_provider.dart';

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
  //Like and Unlike
  late int selectedItemIndex;

  void toggleLike(String title) {
    setState(() {
      final activityProvider =
          Provider.of<ActivityProvider>(context, listen: false);
      final index =
          activityProvider.activities.indexWhere((item) => item.title == title);
      if (index != -1) {
        activityProvider.activities[index] = activityProvider.activities[index]
            .copyWith(isLiked: !activityProvider.activities[index].isLiked);

        // Update Firestore with isLiked status
        FirebaseFirestore.instance
            .collection('activities')
            .doc(title)
            .set(activityProvider.activities[index].toJson());
      }
    });
  }

  //Initial Stage
  @override
  void initState() {
    super.initState();
    // Fetch activities when the page initializes
    Provider.of<ActivityProvider>(context, listen: false).fetchActivities();
  }

  //Main Widget
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
                            title: Text(activities[index].title),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // bool isLiked = activityProvider.activities[index].isLiked;
                            // toggleLike(activities[index].title, isLiked);
                            String title = activities[index].title;
                            toggleLike(title);
                            // String activity = activityProvider.activities[index].title;
                            //activityProvider.addDataToFirestore();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    activityProvider.activities[index].isLiked
                                        ? 'Activity liked!'
                                        : 'Activity unliked!'),
                              ),
                            );
                          },
                          icon: Icon(
                            activities[index].isLiked // fixed
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: activities[index].isLiked // fixed
                                ? Colors.red
                                : null,
                          ),
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
