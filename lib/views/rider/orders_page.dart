import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:mobile_laundry/widgets/bottom_bar_rider.dart';
import 'package:mobile_laundry/widgets/normal_appbar.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppBar(title: 'Orders', isCenter: false),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 100,
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        // to Details Page
                      },
                      horizontalTitleGap: 50,
                      minVerticalPadding: 10,
                      enabled: true,
                      visualDensity: VisualDensity.adaptivePlatformDensity,
                      isThreeLine: true,
                      dense: false,
                      title: const Text('User12'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SizedBox(height: 8),
                          Text('Address: '),
                          SizedBox(height: 8),
                          Text('Price :'),
                          // SizedBox(height: 8),
                          // Text('Pick Up at :'),
                          // SizedBox(height: 8),
                          // Text('Deliver at :'),
                        ],
                      ),
                      trailing: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => BottomBarRider(page: 1)),
                            (Route<dynamic> route) => false,
                          );
                        },
                        icon: const HeroIcon(HeroIcons.check),
                        label: const Text('Accept'),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
