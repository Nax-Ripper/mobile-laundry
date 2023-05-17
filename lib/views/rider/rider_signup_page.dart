import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_laundry/controllers/rider_controller/rider_signup_controller.dart';

enum Auth { signIn, signUp }

class RiderSignupPage extends StatefulWidget {
  const RiderSignupPage({super.key});

  @override
  State<RiderSignupPage> createState() => _RiderSignupPageState();
}

class _RiderSignupPageState extends State<RiderSignupPage> {
  Auth _auth = Auth.signIn;
  final _formKey = GlobalKey<FormState>();
  final _signInFromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RiderSignupPageController>(
      init: RiderSignupPageController(),
      builder: (ctrl) {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text('Hello Riders', style: TextStyle(fontSize: 22)),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: const Text('Create Account'),
                      leading: Radio(
                        value: Auth.signUp,
                        groupValue: _auth,
                        onChanged: (Auth? auth) => {
                          setState(() {
                            _auth = auth ?? Auth.signUp;
                          })
                        },
                      ),
                    ),
                  ),
                  _auth == Auth.signUp
                      ? Column(
                          children: [
                            // const Text('Rider Register'),
                            // const SizedBox(
                            //   height: 30,
                            // ),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          decoration: const InputDecoration(
                                            labelText: 'Name',
                                            border: OutlineInputBorder(),
                                          ),
                                          validator: (value) {
                                            if (value == '') {
                                              return 'Please enter your name';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            ctrl.icImage.clear();
                                            ctrl.drivingLisence.clear();
                                            ctrl.name = value;

                                            ctrl.update();
                                          },
                                        ),
                                        const SizedBox(height: 16.0),
                                        TextFormField(
                                          decoration: const InputDecoration(
                                            labelText: 'Email',
                                            border: OutlineInputBorder(),
                                          ),
                                          validator: (value) {
                                            if (value == '') {
                                              return 'Please enter your email address';
                                            }
                                            if (!RegExp(
                                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                                .hasMatch(value!)) {
                                              return 'Please enter a valid email address';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            ctrl.email = value;
                                          },
                                        ),
                                        const SizedBox(height: 16.0),
                                        TextFormField(
                                          keyboardType: TextInputType.phone,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(11)
                                          ],
                                          decoration: const InputDecoration(
                                            labelText: 'Phone',
                                            border: OutlineInputBorder(),
                                          ),
                                          validator: (value) {
                                            if (value == '') {
                                              return 'Please enter your phone number';
                                            }

                                            return null;
                                          },
                                          onChanged: (value) {
                                            ctrl.phoneNumber = value;
                                            ctrl.update();
                                          },
                                        ),
                                        const SizedBox(height: 16.0),
                                        Visibility(
                                          visible: ctrl.name.isNotEmpty,
                                          child: Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  // ctrl.selectImage();
                                                  if (ctrl.name != '') {
                                                    ctrl.selectImageAndUpload(
                                                      isIc: true,
                                                      name: ctrl.name,
                                                    );
                                                  }
                                                },
                                                child: ctrl.icImage.isNotEmpty
                                                    ? CarouselSlider(
                                                        options:
                                                            CarouselOptions(
                                                          viewportFraction: 1,
                                                          height: 200,
                                                        ),
                                                        items: ctrl.icImage
                                                            .map(
                                                              (e) => Builder(
                                                                builder:
                                                                    (context) {
                                                                  return Image
                                                                      .file(
                                                                    e,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    height: 200,
                                                                  );
                                                                },
                                                              ),
                                                            )
                                                            .toList(),
                                                      )
                                                    : DottedBorder(
                                                        borderType:
                                                            BorderType.RRect,
                                                        radius: const Radius
                                                            .circular(10),
                                                        dashPattern: const [
                                                          10,
                                                          4
                                                        ],
                                                        strokeCap:
                                                            StrokeCap.round,
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 150,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              const Icon(
                                                                Icons
                                                                    .folder_open_rounded,
                                                                size: 40,
                                                              ),
                                                              const SizedBox(
                                                                height: 15,
                                                              ),
                                                              Text(
                                                                'Identification Card (Front)',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .grey[
                                                                        400]),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 16.0),
                                        Visibility(
                                          visible: ctrl.name.isNotEmpty,
                                          child: GestureDetector(
                                            onTap: () {
                                              if (ctrl.name != '') {
                                                ctrl.selectImageAndUpload(
                                                  isIc: false,
                                                  name: ctrl.name,
                                                );
                                              }
                                            },
                                            child: ctrl
                                                    .drivingLisence.isNotEmpty
                                                ? CarouselSlider(
                                                    options: CarouselOptions(
                                                      viewportFraction: 1,
                                                      height: 200,
                                                    ),
                                                    items: ctrl.drivingLisence
                                                        .map(
                                                          (e) => Builder(
                                                            builder: (context) {
                                                              return Image.file(
                                                                e,
                                                                fit: BoxFit
                                                                    .cover,
                                                                height: 200,
                                                              );
                                                            },
                                                          ),
                                                        )
                                                        .toList(),
                                                  )
                                                : DottedBorder(
                                                    borderType:
                                                        BorderType.RRect,
                                                    radius:
                                                        const Radius.circular(
                                                            10),
                                                    dashPattern: const [10, 4],
                                                    strokeCap: StrokeCap.round,
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 150,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const Icon(
                                                            Icons
                                                                .folder_open_rounded,
                                                            size: 40,
                                                          ),
                                                          const SizedBox(
                                                            height: 15,
                                                          ),
                                                          Text(
                                                            'Driving Lisence (Front)',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey[400]),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: ctrl.icImage.isEmpty ||
                                                  ctrl.drivingLisence.isEmpty
                                              ? null
                                              : () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    _formKey.currentState!
                                                        .save();
                                                    // call api
                                                    ctrl.signUpRider(
                                                        context: context,
                                                        name: ctrl.name,
                                                        email: ctrl.email,
                                                        icURL: ctrl.icUrl,
                                                        lisenceURL: ctrl
                                                            .drivingLisenceUrl,
                                                        phone:
                                                            ctrl.phoneNumber);

                                                    ctrl.update();

                                                    // route to new page
                                                    log('hello');
                                                  }
                                                },
                                          child: const SizedBox(
                                            width: 300,
                                            child: Center(
                                                child: Text('Register!')),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: const Text('Sign In'),
                      leading: Radio(
                        value: Auth.signIn,
                        groupValue: _auth,
                        onChanged: (Auth? auth) => {
                          setState(() {
                            _auth = auth ?? Auth.signIn;
                          })
                        },
                      ),
                    ),
                  ),
                  _auth == Auth.signIn
                      ? Form(
                          key: _signInFromKey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Email',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == '') {
                                      return 'Please enter your email address';
                                    }
                                    if (!RegExp(
                                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                        .hasMatch(value!)) {
                                      return 'Please enter a valid email address';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    ctrl.email = value;
                                  },
                                ),
                                const SizedBox(height: 16.0),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Password',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == '') {
                                      return 'Please enter passwword';
                                    }
                                    // if (!RegExp(
                                    //         r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    //     .hasMatch(value!)) {
                                    //   return 'Please enter a valid email address';
                                    // }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    ctrl.password = value;
                                  },
                                ),
                                const SizedBox(height: 16.0),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_signInFromKey.currentState!
                                        .validate()) {
                                      _formKey.currentState!.save();
                                      // call api
                                      // route to new page
                                      log('hello');
                                    }
                                  },
                                  child: const SizedBox(
                                    width: 300,
                                    child: Center(child: Text('Sign In')),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : SizedBox()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
