import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dafluta/dafluta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nukegame/json/json_match.dart';
import 'package:nukegame/json/json_slot.dart';
import 'package:nukegame/models/document.dart';
import 'package:nukegame/services/palette.dart';

class MatchScreen extends StatelessWidget {
  final MatchState state;

  const MatchScreen._(this.state);

  factory MatchScreen.instance(DocumentReference matchDocRef, JsonMatch match) => MatchScreen._(MatchState(matchDocRef, match));

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
          Expanded(
            child: BaseMap(
              slots: state.enemySlots,
              callback: null,
            ),
          ),
          Container(
            color: Palette.black,
            height: constraints.maxHeight / 10,
            child: MessageBanner(state),
          ),
          Expanded(
            child: BaseMap(
              slots: state.ownSlots,
              callback: state.onSlotSelected,
            ),
          ),
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
  final List<JsonSlot> slots;
  final Function(JsonSlot)? callback;

  const BaseMap({
    required this.slots,
    required this.callback,
  });

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
            for (final JsonSlot slot in slots)
              Container(
                color: Colors.teal[100],
                child: Text(slot.id),
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
  late final String userId;
  StreamSubscription? subscription;
  Timer? timer;
  JsonMatch match;
  String messageBanner = '';
  int credits = 0;

  MatchState(this.matchDocRef, this.match);

  List<JsonSlot> get enemySlots => match.slots.where((e) => e.owner != userId).toList();

  List<JsonSlot> get ownSlots => match.slots.where((e) => e.owner == userId).toList();

  @override
  void onLoad() {
    userId = FirebaseAuth.instance.currentUser!.uid;

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

  void onSlotSelected(JsonSlot slot) {
    print(slot.id);
  }
}
