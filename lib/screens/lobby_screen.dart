import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dafluta/dafluta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nukegame/json/json_match.dart';
import 'package:nukegame/json/json_slot.dart';
import 'package:nukegame/models/document.dart';
import 'package:nukegame/services/navigation.dart';
import 'package:nukegame/types/lobby_status.dart';
import 'package:nukegame/types/slot_state.dart';
import 'package:nukegame/widgets/custom_form_field.dart';

class LobbyScreen extends StatelessWidget {
  final LobbyState state;

  const LobbyScreen._(this.state);

  factory LobbyScreen.instance() => LobbyScreen._(LobbyState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StateProvider<LobbyState>(
        state: state,
        builder: (context, state) {
          switch (state.status) {
            case LobbyStatus.form:
              return ContentForm(state);
            case LobbyStatus.waiting:
              return const ContentMessage('Waiting for players…');
            case LobbyStatus.joining:
              return const ContentMessage('Joining match…');
          }
        },
      ),
    );
  }
}

class ContentForm extends StatelessWidget {
  final LobbyState state;

  const ContentForm(this.state);

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

class ContentMessage extends StatelessWidget {
  final String message;

  const ContentMessage(this.message);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const HBox(20),
          Text(message),
        ],
      ),
    );
  }
}

class LobbyState extends BaseState {
  LobbyStatus status = LobbyStatus.form;
  DocumentReference? matchDocRef;
  StreamSubscription? subscription;
  final TextEditingController matchIdController = TextEditingController();

  Future onCreateMatch() async {
    final String matchId = matchIdController.text.trim();

    if (matchId.isNotEmpty) {
      status = LobbyStatus.waiting;
      notify();

      final String userId = FirebaseAuth.instance.currentUser!.uid;

      final JsonMatch match = JsonMatch(
        id: matchId,
        players: [userId],
        slots: _newSlots(from: 1, owner: userId),
      );

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
      status = LobbyStatus.joining;
      notify();

      matchDocRef = _docRef(matchId);
      final String userId = FirebaseAuth.instance.currentUser!.uid;

      final DocumentSnapshot snapshot = await matchDocRef!.get();
      final Document document = Document.load(snapshot);
      final JsonMatch match = JsonMatch.fromDocument(document);
      match.players.add(userId);
      match.slots.addAll(_newSlots(from: 7, owner: userId));

      await matchDocRef?.set(match.toJson());
      Navigation.matchScreen(matchDocRef!);
    }
  }

  List<JsonSlot> _newSlots({
    required int from,
    required String owner,
  }) {
    final List<JsonSlot> result = [];
    final int min = from;
    final int max = from + 5;
    final baseSlotId = min + Random().nextInt(max - min);

    for (int i = min; i <= max; i++) {
      result.add(
        JsonSlot(
          id: i.toString(),
          owner: owner,
          hidden: true,
          state: (baseSlotId == i) ? SlotState.base : SlotState.empty,
        ),
      );
    }

    return result;
  }
}
