import 'package:flutter/material.dart';
import 'package:flutter_application_1/sprint/sprint.dart';
import 'package:flutter_application_1/sprint/sprint_model.dart';
import 'package:flutter_application_1/sprint/sprint_share.dart';
import 'package:flutter_application_1/storage/db_handler.dart';
import 'package:flutter_application_1/ui/button/card_button.dart';
import 'package:flutter_application_1/ui/route/fade_route.dart';
import 'package:flutter_application_1/utils/date_utils.dart';

class DefaultSprintCard extends StatelessWidget {
  const DefaultSprintCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: CardButton(
          onTap: () {},
          title: 'Sprint',
          description: "Jusqu'à 10 mots à trouver en 5 minutes",
          next: 'Disponible tous les dimanches',
          disabled: true,
          success: null,
          enableShare: false,
          onShare: () {},
        ),
      ),
    );
  }
}

class HomeSprintCard extends StatelessWidget {
  HomeSprintCard({Key? key}) : super(key: key);
  final DatabaseHandler handler = DatabaseHandler('motus.db');

  void goToGame(BuildContext context, Sprint sprint, String mode) {
    Navigator.push(
      context,
      FadeRoute(
        page: SprintWordRoute(
          sprint: sprint,
          mode: mode,
        ),
      ),
    );
  }

  void onShare(BuildContext context, int score) async {
    await shareSprintResults(score);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 1, milliseconds: 200),
        content: Text('Résumé copié dans le presse papier'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        // handler.openDB(),
        handler.retrieveFreeSprints(),
        handler.retrieveSprintChallenge(formattedToday()),
      ]),
      builder: (context, AsyncSnapshot<List<Object?>> snapshot) {
        if (snapshot.hasData) {
          final List<Sprint?> freeSprints = snapshot.data![0] as List<Sprint?>;
          final Sprint? sprint = snapshot.data![1] as Sprint?;

          if (freeSprints.isNotEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: CardButton(
                  title: 'Sprint',
                  description: "Jusqu'à 10 mots à trouver en 5 minutes",
                  next: 'Parties gratuites: ${freeSprints.length}',
                  onTap: () {
                    goToGame(
                        context, freeSprints.first as Sprint, 'sprint_free');
                  },
                  enableShare: false,
                ),
              ),
            );
          } else if (sprint != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: CardButton(
                  title: 'Sprint',
                  description: "Jusqu'à 10 mots à trouver en 5 minutes",
                  next: 'Disponible tous les dimanches',
                  disabled: sprint.score == null ? false : true,
                  success: sprint.score == null ? null : true,
                  enableShare: sprint.score == null ? false : true,
                  onTap: () {
                    goToGame(context, sprint, 'sprint');
                  },
                  onShare: () {
                    onShare(context, sprint.score ?? 0);
                  },
                ),
              ),
            );
          } else {
            return const DefaultSprintCard();
          }
        } else {
          return const DefaultSprintCard();
        }
      },
    );
  }
}
