import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:nukegame/services/navigation.dart';

class LoadingDialog extends StatelessWidget {
  final String text;

  const LoadingDialog._(this.text);

  static DialogController loading(String text) {
    final BuildContext context = Navigation.context();

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => LoadingDialog._(text),
    );

    return DialogController(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(25),
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: Theme.of(context).colorScheme.primary),
            const HBox(30),
            Text(text),
          ],
        ),
      ),
    );
  }
}
