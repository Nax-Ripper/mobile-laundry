import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:heroicons/heroicons.dart';
import 'package:mobile_laundry/config/global_variables.dart';
import 'package:mobile_laundry/views/account/account_page.dart';
import 'package:mobile_laundry/views/rider/delivery_page.dart';
import 'package:mobile_laundry/views/rider/orders_page.dart';

class BottomBarRider extends StatefulWidget {
  int? page;
  BottomBarRider({
    Key? key,
    this.page,
  }) : super(key: key);

  @override
  State<BottomBarRider> createState() => _BottomBarRiderState();
}

class _BottomBarRiderState extends State<BottomBarRider> {
  int page = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    page = widget.page ?? 0;
  }

  void setPage(int newPage) {
    setState(() {
      page = newPage;
    });
  }

  List<Widget> pages = [
    OrdersPage(),
    DeliveryPage(),
    AccountPage(),
  ];
  double bottomBarWidth = 42;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[page],
      bottomNavigationBar: BottomNavigationBar(
        onTap: setPage,
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: page == 0
                        ? GlobalVariables.primaryColor
                        : GlobalVariables.backgroundColor,
                    width: 5,
                  ),
                ),
              ),
              child: const Icon(
                Icons.bookmark_border,
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
                    color: page == 1
                        ? GlobalVariables.primaryColor
                        : GlobalVariables.backgroundColor,
                    width: 5,
                  ),
                ),
              ),
              // child: const HeroIcon(HeroIcons.handRaised),
              child: const Icon(
                Icons.directions_bike,
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
                    color: page == 2
                        ? GlobalVariables.primaryColor
                        : GlobalVariables.backgroundColor,
                    width: 5,
                  ),
                ),
              ),
              child: const Icon(Icons.person),
              // child: HeroIcon(HeroIcons.),
            ),
          ),
        ],
      ),
    );
  }
}
