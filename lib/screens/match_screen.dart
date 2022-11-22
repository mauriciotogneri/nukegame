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
      backgroundColor: Palette.black,
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
          Expanded(child: BaseMap(state)),
          Container(
            color: Palette.black,
            height: constraints.maxHeight / 10,
            child: MessageBanner(state),
          ),
          Expanded(child: BaseMap(state)),
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

class BaseMap extends StatelessWidget {
  final MatchState state;

  const BaseMap(this.state);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.black,
      child: Center(
        child: GridView.count(
          primary: false,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          crossAxisCount: 3,
          children: [
            Container(
              color: Colors.teal[100],
              child: const Text("He'd have you all unravel at the"),
            ),
            Container(
              color: Colors.teal[200],
              child: const Text('Heed not the rabble'),
            ),
            Container(
              color: Colors.teal[300],
              child: const Text('Sound of screams but the'),
            ),
            Container(
              color: Colors.teal[400],
              child: const Text('Who scream'),
            ),
            Container(
              color: Colors.teal[500],
              child: const Text('Revolution is coming...'),
            ),
            Container(
              color: Colors.teal[600],
              child: const Text('Revolution, they...'),
            ),
          ],
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
  Timer? timer;
  JsonMatch? match;
  String messageBanner = '';
  int credits = 0;

  MatchState(this.matchDocRef);

  @override
  void onLoad() {
    subscription = matchDocRef.snapshots().listen((event) {
      final Document document = Document.load(event);
      match = JsonMatch.fromDocument(document);
      print(match);
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      credits++;
      notify();
    });
  }

  @override
  void onDestroy() {
    subscription?.cancel();
    timer?.cancel();
  }
}
