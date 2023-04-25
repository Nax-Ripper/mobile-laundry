import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:mobile_laundry/models/rider_orders/rider_order.dart';
import 'package:mobile_laundry/widgets/normal_appbar.dart';

class SelectedOrderDetailsPage extends StatelessWidget {
  RiderOrder? order;
  String? Address;
  SelectedOrderDetailsPage({
    Key? key,
    this.order,
    this.Address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppBar(title: '${order?.user?.name} Order' ?? 'Order', isCenter: false),
      body: Column(
        children: [],
      ),
    );
  }
}
