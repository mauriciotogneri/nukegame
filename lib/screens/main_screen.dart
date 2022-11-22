import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dafluta/dafluta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nukegame/json/json_match.dart';
import 'package:nukegame/models/document.dart';
import 'package:nukegame/services/navigation.dart';
import 'package:nukegame/widgets/custom_form_field.dart';

class MainScreen extends StatelessWidget {
  final MainState state;

  const MainScreen._(this.state);

  factory MainScreen.instance() => MainScreen._(MainState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StateProvider<MainState>(
        state: state,
        builder: (context, state) => Content(state),
      ),
    );
  }
}

class Content extends StatelessWidget {
  final MainState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 200,
            child: CustomFormField(
              label: 'Match ID',
              controller: state.matchIdController,
            ),
          ),
          const VBox(20),
          ElevatedButton(
            onPressed: state.onCreateMatch,
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Text('Create match'),
            ),
          ),
          const VBox(20),
          ElevatedButton(
            onPressed: state.onJoinMatch,
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Text('Join match'),
            ),
          ),
        ],
      ),
    );
  }
}

class MainState extends BaseState {
  DocumentReference? matchDocRef;
  StreamSubscription? subscription;
  final TextEditingController matchIdController = TextEditingController();

  Future onCreateMatch() async {
    final String matchId = matchIdController.text.trim();

    if (matchId.isNotEmpty) {
      final JsonMatch match = JsonMatch(id: matchId, players: [
        FirebaseAuth.instance.currentUser!.uid,
      ]);

      matchDocRef = _docRef(matchId);

      await matchDocRef?.set(match.toJson());

      subscription = matchDocRef?.snapshots().listen((event) {
        final Document document = Document.load(event);
        final JsonMatch match = JsonMatch.fromDocument(document);
        _onMatchDocumentChanged(match);
      });
    }
  }

  void _onMatchDocumentChanged(JsonMatch match) {
    if (match.players.length == 2) {
      subscription?.cancel();
      Navigation.matchScreen(matchDocRef!);
    }
  }

  DocumentReference _docRef(String matchId) => FirebaseFirestore.instance.collection('matches').doc(matchId);

  Future onJoinMatch() async {
    final String matchId = matchIdController.text.trim();

    if (matchId.isNotEmpty) {
      matchDocRef = _docRef(matchId);

      final DocumentSnapshot snapshot = await matchDocRef!.get();
      final Document document = Document.load(snapshot);
      final JsonMatch match = JsonMatch.fromDocument(document);
      match.players.add(FirebaseAuth.instance.currentUser!.uid);

      await matchDocRef?.set(match.toJson());
      Navigation.matchScreen(matchDocRef!);
    }
  }
}
