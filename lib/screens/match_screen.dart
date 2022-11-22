import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:nukegame/json/json_match.dart';
import 'package:nukegame/models/document.dart';

class MatchScreen extends StatelessWidget {
  final MatchState state;

  const MatchScreen._(this.state);

  factory MatchScreen.instance(DocumentReference matchDocRef) => MatchScreen._(MatchState(matchDocRef));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StateProvider<MatchState>(
        state: state,
        builder: (context, state) => Content(state),
      ),
    );
  }
}

class Content extends StatelessWidget {
  final MatchState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return const Center();
  }
}

class MatchState extends BaseState {
  final DocumentReference matchDocRef;
  StreamSubscription? subscription;
  JsonMatch? match;

  MatchState(this.matchDocRef);

  @override
  void onLoad() {
    subscription = matchDocRef.snapshots().listen((event) {
      final Document document = Document.load(event);
      match = JsonMatch.fromDocument(document);
      print(match);
    });
  }

  @override
  void onDestroy() {
    subscription?.cancel();
  }
}
