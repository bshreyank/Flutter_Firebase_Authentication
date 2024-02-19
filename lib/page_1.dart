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
