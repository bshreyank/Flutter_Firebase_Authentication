import 'package:complete/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Page_1 extends StatelessWidget {
  const Page_1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ActivityProvider>(
      builder: (context, activityProvider, _) {
        /*
                  log(
                    'isloading: ${activityProvider.isloading}',
                    name: 'activity',
                  );
                  log(
                    'list: ${activityProvider.list}',
                    name: 'activity',
                  );
                  */
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200,
                  width: 300,
                  child: Card(
                    color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Align(
                          alignment: Alignment.center,
                          child: activityProvider.isloading
                              ? const CircularProgressIndicator()
                              : Text(
                                  activityProvider.activity,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        color: Colors.white,
                                      ),
                                  textAlign: TextAlign.center,
                                )),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    activityProvider.fetchActivity();
                  },
                  child: const Text("Next Activity"),
                ),
              ],
            ),
          ),
        );
      }, // builder
    );
  }
}
