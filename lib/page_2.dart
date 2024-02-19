import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'activity_provider.dart';

class Page_2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ActivityProvider>(
      builder: (context, activityProvider, _) {
        final selectedActivities = activityProvider.selectedActivities;

        return Scaffold(
          appBar: AppBar(
            title: Text('Selected Activities'),
          ),
          body: ListView.builder(
            itemCount: selectedActivities.length,
            itemBuilder: (context, index) {
              final activity = selectedActivities[index];
              return ListTile(
                title: Text(activity.activity),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Delete the activity
                    activityProvider.deleteActivity(activity);
                  },
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Delete all activities
              activityProvider.deleteAllActivities();
            },
            child: Icon(Icons.delete_forever),
            tooltip: 'Delete All',
          ),
        );
      },
    );
  }
}
