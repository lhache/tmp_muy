import 'package:flutter/material.dart';
import 'package:flutter_application_1/design/design.dart';
import 'package:flutter_application_1/routes/daily.dart';
import 'package:flutter_application_1/routes/random.dart';
import 'package:flutter_application_1/routes/sprint.dart';
import 'package:flutter_application_1/routes/stats.dart';
import 'package:flutter_application_1/utils/date_utils.dart';

import '../DatabaseHandler.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DatabaseHandler handler = DatabaseHandler('motus.db');

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: handler.dailyHasBeenPlayed(formattedToday()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final hasBeenPlayed = snapshot.data;
            // Build the widget with data.
            return Scaffold(
                backgroundColor: CustomColors.backgroundColor,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: ElevatedButton(
                        child: const Text('random'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Random()),
                          );
                        },
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        child: const Text('daily'),
                        onPressed: hasBeenPlayed == true
                            ? () {}
                            : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const DailyRoute()),
                                );
                              },
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        child: const Text('sprint'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Sprint()),
                          );
                        },
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        child: const Text('stats'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Stats()),
                          );
                        },
                      ),
                    ),
                  ],
                ));
          } else {
            // We can show the loading view until the data comes back.
            debugPrint('Step 1, build loading widget');
            return const CircularProgressIndicator();
          }
        },
      );
}
