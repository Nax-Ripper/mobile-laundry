import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grid_staggered_lite/grid_staggered_lite.dart';
import 'package:mobile_laundry/controllers/admin_controller/admin_services_controller.dart';
import 'package:mobile_laundry/routes/route_name.dart';
import 'package:simple_annimated_staggered/simple_annimated_staggered.dart';

class AdminHome2 extends StatelessWidget {
  AdminServicesProduct ctrl = Get.put(AdminServicesProduct());
  static const List<StaggeredTile> _staggeredTiles = <StaggeredTile>[
    StaggeredTile.count(2, 1),
    StaggeredTile.count(1, 2),
    StaggeredTile.count(1, 1),
    StaggeredTile.count(1, 1),
    StaggeredTile.count(1, 1),
    StaggeredTile.count(1, 1),
    // StaggeredTile.count(2, 1),
  ];

  AdminHome2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _cardWidgets = [
      GetBuilder(
        init: ctrl,
        builder: (ctrl) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RouteName.approvedRiderPage);
            },
            child: buildCardWidget(
              context: context,
              text: 'Riders',
              icon: Icons.motorcycle_sharp,
              color: Colors.white,
              // count: ctrl.products.length.toString(),
              // count: ctrl.riderApprovalCtrl.riders.riders?.length.toString()?? '0',
              count: ctrl.approvedRider.riders?.length.toString() ?? '0',
            ),
          );
        },
      ),
      GetBuilder(
        init: ctrl,
        builder: (ctrl) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RouteName.riderApprovalPage);
            },
            child: buildCardWidget(
              context: context,
              text: 'Approvals',
              icon: Icons.note_add_sharp,
              color: Colors.white,
              // count: '30',
              count: ctrl.appliedRiders.riders?.length.toString() ?? '0',
            ),
          );
        },
      ),
      GestureDetector(
        onTap: () {
          // Handle 'Order' onTap
          CherryToast.info(title: Text('This is only viewable')).show(context);
        },
        child: GetBuilder(
          init: ctrl,
          builder: (ctrl) {
            return buildCardWidget(
              context: context,
              text: 'Orders',
              icon: null,
              color: Colors.white,
              count: ctrl.riderOrders.riderOrders?.length.toString() ?? '0',
            );
          },
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RouteName.adminServiceListPage);
        },
        child: GetBuilder(
          init: ctrl,
          builder: (controller) {
            return buildCardWidget(
              context: context,
              text: 'Total Products',
              icon: Icons.delete,
              color: Colors.white,
              count: ctrl.products.length.toString(),
            );
          },
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RouteName.profilePage);
        },
        child: buildCardWidget(
          context: context,
          text: 'Admin Profile',
          icon: Icons.face_retouching_natural_sharp,
          color: Colors.white,
          count: '',
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RouteName.adminAssetsPage);
        },
        child: buildCardWidget(
          context: context,
          text: 'Assets',
          icon: Icons.warehouse_sharp,
          color: Colors.white,
          count: '8',
        ),
      ),
      // GestureDetector(
      //   onTap: () {
      //     // Navigator.pushNamed(context, RouteName.reportsPage);
      //   },
      //   child: buildCardWidget(
      //     context: context,
      //     text: 'Reports',
      //     icon: Icons.assignment_sharp,
      //     color: Colors.white,
      //     count: '',
      //   ),
      // ),
    ];

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: AnimationLimiter(
        child: GetBuilder<AdminServicesProduct>(
          init: AdminServicesProduct(),
          builder: (controller) {
            return RefreshIndicator(
              onRefresh: () async {
               await ctrl.getProduct();
               await ctrl.getAppliedRiders(isApproved: false);
               await ctrl.getAppliedRiders(isApproved: true);
               await ctrl.getAllOrders();
              },
              child: StaggeredGridView.count(
                staggeredTiles: _staggeredTiles,
                crossAxisCount: 2,
                children: List.generate(
                  _staggeredTiles.length,
                  (int index) {
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 400),
                      columnCount: 2,
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                          child: _cardWidgets[index],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildCardWidget({
    required BuildContext context,
    required String text,
    required IconData? icon,
    required Color color,
    required String count,
  }) {
    return Card(
      elevation: 30,
      shadowColor: Colors.amber,
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
                SizedBox(height: 10),
                if (icon != null)
                  Material(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(
                        icon,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                SizedBox(height: 10),
                Text(
                  count,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
