import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:heroicons/heroicons.dart';

import 'package:mobile_laundry/config/global_variables.dart';
import 'package:mobile_laundry/models/rider_orders/rider_order.dart';
import 'package:mobile_laundry/views/account/account_page.dart';
import 'package:mobile_laundry/views/rider/delivery_page.dart';
import 'package:mobile_laundry/views/rider/orders_page.dart';
import 'package:mobile_laundry/views/rider/past_orders_page.dart';

class BottomBarRider extends StatefulWidget {
  int? page;
  String? id;
  BottomBarRider({
    Key? key,
    this.page,
    this.id,
  }) : super(key: key);

  @override
  State<BottomBarRider> createState() => _BottomBarRiderState();
}

class _BottomBarRiderState extends State<BottomBarRider> {
  int page = 0;
  String customerId = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    page = widget.page ?? 0;
    customerId = widget.id ?? '';
  }

  void setPage(int newPage) {
    setState(() {
      page = newPage;
    });
  }

  double bottomBarWidth = 42;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      OrdersPage(),
      DeliveryPage(id: customerId),
      PastOrderPage(),
      AccountPage(),
    ];
    return Scaffold(
      body: pages[page],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 15,

        // backgroundColor: Colors.amber,
        onTap: setPage,
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: page == 0 ? GlobalVariables.primaryColor : GlobalVariables.backgroundColor,
                    width: 5,
                  ),
                ),
              ),
              child: const Icon(
                Icons.bookmark_border,
                color: GlobalVariables.primaryColor,
              ),
              // child: const HeroIcon(HeroIcons.calendar),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: page == 1 ? GlobalVariables.primaryColor : GlobalVariables.backgroundColor,
                    width: 5,
                  ),
                ),
              ),
              child: const Icon(
                Icons.directions_bike,
                color: GlobalVariables.primaryColor,
              ),
              //  badges.Badge(
              //   badgeContent: Text('2'),
              //   badgeStyle: badges.BadgeStyle(
              //     elevation: 0,
              //     badgeColor: Colors.white,
              //   ),
              //   child: Icon(Icons.add),
              // ),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: page == 2 ? GlobalVariables.primaryColor : GlobalVariables.backgroundColor,
                    width: 5,
                  ),
                ),
              ),
              child: const Icon(
                Icons.notes_outlined,
                color: GlobalVariables.primaryColor,
              ),
              // child: HeroIcon(HeroIcons.),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: page == 3 ? GlobalVariables.primaryColor : GlobalVariables.backgroundColor,
                    width: 5,
                  ),
                ),
              ),
              child: const Icon(
                Icons.person,
                color: GlobalVariables.primaryColor,
              ),
              // child: HeroIcon(HeroIcons.),
            ),
          ),
        ],
      ),
    );
  }
}
