import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:mobile_laundry/controllers/admin_controller/admin_services_controller.dart';
import 'package:mobile_laundry/routes/route_name.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  AdminServicesProduct adminService = Get.put(AdminServicesProduct());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adminService.getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminServicesProduct>(
      // init: adminService,
      init: adminService,
      builder: (ctrl) {
        return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              tooltip: 'Add Items',
              onPressed: () {
                Navigator.pushNamed(context, RouteName.addProuctPage);
              },
              child: Icon(Icons.add),
            ),
            appBar: AppBar(
              title: Text('Products'),
            ),
            body: ctrl.isLoading == true
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: ctrl.products.length,
                          itemBuilder: (context, i) {
                            return Card(
                              child: ListTile(
                                // leading: ctrl.orderListCtrl.items[i].image,
                                leading:
                                    Image.network(ctrl.products[i].images[0]),
                                title: Text(ctrl.products[i].name),
                                subtitle: Text('RM ${ctrl.products[i].price}'),
                                // trailing: Icon(Icons.arrow_forward_ios_sharp),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ));
      },
    );
  }
}
