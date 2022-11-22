import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:nukegame/json/json_match.dart';
import 'package:nukegame/models/document.dart';
import 'package:nukegame/services/palette.dart';

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
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          const Expanded(child: Placeholder()),
          Container(
            color: Palette.black,
            height: constraints.maxHeight / 10,
            child: MessageBanner(state),
          ),
          const Expanded(child: Placeholder()),
          Container(
            color: Palette.black,
            height: constraints.maxHeight / 10,
            child: CreditBanner(state),
          ),
        ],
      ),
    );
  }
}

class MessageBanner extends StatelessWidget {
  final MatchState state;

  const MessageBanner(this.state);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (context, constraints) => Text(
            state.messageBanner,
            style: TextStyle(
              fontSize: constraints.maxHeight / 2,
              fontWeight: FontWeight.bold,
              color: Palette.red,
            ),
          ),
        ),
      ),
    );
  }
}

class CreditBanner extends StatelessWidget {
  final MatchState state;

  const CreditBanner(this.state);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (context, constraints) => Text(
            state.credits.toString(),
            style: TextStyle(
              fontSize: constraints.maxHeight,
              fontWeight: FontWeight.bold,
              color: Palette.white,
            ),
          ),
        ),
      ),
    );
  }
}

class MatchState extends BaseState {
  final DocumentReference matchDocRef;
  StreamSubscription? subscription;
  JsonMatch? match;
  String messageBanner = '';
  int credits = 100;

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
