import 'package:complete/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Page_2 extends StatelessWidget {
  const Page_2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:
          Consumer<ActivityProvider>(builder: (context, activityProvider, _) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...activityProvider.list
                .map(
                  (e) => ListTile(
                    title: Text(e),
                    trailing: IconButton(
                      onPressed: () {
                        //log('activity: $e', name: 'activity');
                        activityProvider.handleDeleteActivity(e);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ),
                )
                .toList(),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: ElevatedButton(
                onPressed: () {
                  activityProvider.handleDeleteAll();
                },
                child: const Text("Delete All"),
              ),
            ),
          ],
        );
      }),
    );
  }
}
