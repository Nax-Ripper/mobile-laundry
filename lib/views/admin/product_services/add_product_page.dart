// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:mobile_laundry/controllers/admin_controller/add_product_controller.dart';
import 'package:mobile_laundry/widgets/custom_textfields.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Products'),
        ),
        body: GetBuilder<AddProductController>(
          init: AddProductController(),
          builder: (ctrl) {
            return SingleChildScrollView(
              child: Form(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        ctrl.selectImage();
                      },
                      child: ctrl.images.isNotEmpty
                          ? CarouselSlider(
                              options: CarouselOptions(
                                viewportFraction: 1,
                                height: 200,
                              ),
                              items: ctrl.images
                                  .map(
                                    (e) => Builder(
                                      builder: (context) {
                                        return Image.file(
                                          e,
                                          fit: BoxFit.cover,
                                          height: 200,
                                        );
                                      },
                                    ),
                                  )
                                  .toList(),
                            )
                          : DottedBorder(
                              borderType: BorderType.RRect,
                              radius: Radius.circular(10),
                              dashPattern: [10, 4],
                              strokeCap: StrokeCap.round,
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.folder_open_rounded,
                                      size: 40,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'Select Product Images',
                                      style: TextStyle(color: Colors.grey[400]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CustomTextField(
                        controller: ctrl.productName, hintText: 'Product Name'),
                    CustomTextField(
                        controller: ctrl.description,
                        hintText: 'Description',
                        maxLines: 5),
                    CustomTextField(controller: ctrl.price, hintText: 'Price'),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          ctrl.uploadProduct(
                              context: context,
                              name: ctrl.productName.text,
                              description: ctrl.description.text,
                              price: double.parse(ctrl.price.text),
                              images: ctrl.images);

                          ctrl.update();
                        },
                        child: Text('Upload'))
                  ],
                ),
              )),
            );
          },
        ));
  }
}
