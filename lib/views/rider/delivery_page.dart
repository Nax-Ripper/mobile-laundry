import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile_laundry/widgets/custom_textfields.dart';
import 'package:mobile_laundry/widgets/normal_appbar.dart';

TextEditingController optController = TextEditingController();

class DeliveryPage extends StatelessWidget {
  const DeliveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NormalAppBar(title: 'Taken Order', isCenter: false),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Order Details'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('j1Sro-5Lw7(#255)'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Marry Williams'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      OrderItems(),
                      Divider(
                        color: Colors.black,
                      ),
                      Container(
                        child: ListTile(
                          subtitle: Text('Online'),
                          title: Text('Payment'),
                          trailing: Text('RM 16'),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 250,
                            child: CustomTextField(
                              controller: optController,
                              hintText: 'Enter OTP',
                            ),
                          ),
                          SizedBox(
                            height: 57,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text('verify'),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Center(
                    child: SizedBox(
                      width: 250,
                      child: ElevatedButton(
                        onPressed: optController.text.isEmpty
                            ? null
                            : () {
                                log('Hello');
                              },
                        child: Text('Picked Up'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

Widget OrderItems() {
  return ExpansionTile(
    title: Text('Order Items (4 items)'),
    expandedCrossAxisAlignment: CrossAxisAlignment.start,
    expandedAlignment: Alignment.centerLeft,
    children: List.generate(
      4,
      (index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Marry Williams'),
      ),
    ),
  );
}
