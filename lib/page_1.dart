import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:complete/page_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
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
  //saved and not saved
  void toggleSave(String title) {
    setState(() {
      final activityProvider =
          Provider.of<ActivityProvider>(context, listen: false);
      final index =
          activityProvider.activities.indexWhere((item) => item.title == title);

      if (index != -1) {
        bool isSaved = !activityProvider.activities[index].isSaved;

        activityProvider.activities[index] =
            activityProvider.activities[index].copyWith(isSaved: isSaved);

        FirebaseFirestore.instance
            .collection(FirebaseAuth.instance.currentUser!.uid)
            .doc(title)
            .set(activityProvider.activities[index].toJson());
      }
    });
  }

  //Like and Unlike
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
            .collection(FirebaseAuth.instance.currentUser!.uid)
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
                    //strikethrough functionality
                    final activity = activities[index];
                    final bool isLikedAndSaved =
                        activity.isLiked && activity.isSaved;
                    return Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text(
                              activities[index].title,
                              style: TextStyle(
                                decoration: isLikedAndSaved
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
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
                            //activityProvider.addsetSelectedActivity(activities[index]);
                            // Navigate to Page_2
                            //Navigator.pushNamed(context, '/page2');
                            //===============>>>>
                            String title = activities[index].title;
                            toggleSave(title);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    activityProvider.activities[index].isSaved
                                        ? 'Activity saved!'
                                        : 'Activity removed from saved!'),
                              ),
                            );
                          },
                          icon: Icon(
                            activities[index].isSaved ? Icons.check : Icons.add,
                            color:
                                activities[index].isSaved ? Colors.green : null,
                          ),
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
