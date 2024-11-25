import 'package:flutter/material.dart';

///todo this can have the cards, but if you dont have card then you show the 1 card,
///if no card then we have create a card screen
///
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("No cards available"),
      ),
    );
  }
}
