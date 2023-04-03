import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class showSheet extends StatefulWidget {
  const showSheet({super.key});

  @override
  State<showSheet> createState() => _showSheetState();
}

class _showSheetState extends State<showSheet> {
  void displayPersistentBottomSheet() {
    Scaffold.of(context).showBottomSheet<void>((BuildContext context) {
      return Container(
        color: Colors.amber,
        height: 200, // 👈 Change this according to your need
        child: const Center(child: Text("Image Filter Here")),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
