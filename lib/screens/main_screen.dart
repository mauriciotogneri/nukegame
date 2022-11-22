import 'package:dafluta/dafluta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      child: Text('ID: ${FirebaseAuth.instance.currentUser!.uid}'),
    );
  }
}

class MainState extends BaseState {}
