import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dafluta/dafluta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nukegame/json/json_match.dart';
import 'package:nukegame/models/document.dart';
import 'package:nukegame/services/navigation.dart';

class SplashScreen extends StatelessWidget {
  final SplashState state;

  const SplashScreen._(this.state);

  factory SplashScreen.instance() => SplashScreen._(SplashState());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class SplashState extends BaseState {
  @override
  Future onLoad() async {
    final Stream<User?> stream = FirebaseAuth.instance.authStateChanges();
    StreamSubscription? subscription;
    subscription = stream.listen((user) {
      subscription?.cancel();
      _processUser(user);
    });
  }

  Future _processUser(User? user) async {
    if (user != null) {
      await user.reload();
    } else {
      await FirebaseAuth.instance.signInAnonymously();
    }

    //Navigation.lobbyScreen();
    final matchDocRef = FirebaseFirestore.instance.collection('matches').doc('xxx');
    final snapshot = await matchDocRef.get();
    final Document document = Document.load(snapshot);
    final JsonMatch match = JsonMatch.fromDocument(document);
    Navigation.matchScreen(matchDocRef: matchDocRef, match: match);
  }
}
