import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mobile_laundry/widgets/normal_appbar.dart';

class AdminAssetPage extends StatelessWidget {
  const AdminAssetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppBar(title: 'Admin Assets', isCenter: false),
      body: ListView(
        children: [
          Card(child: ListTile(leading: Text('Washing Machine (14kg)'),trailing: Text('x3'))),
          Card(child: ListTile(leading: Text('Dryer (25kg)'),trailing: Text('x4'))),
          Card(child: ListTile(leading: Text('Coin Exchange Machine'),trailing: Text('x1'))),
        ],
      ),
    );
  }
}