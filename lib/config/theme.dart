import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    appBarTheme: const AppBarTheme(
      color: Color.fromARGB(195, 62, 27, 100),
      titleTextStyle: TextStyle(color: Colors.white),
    ),
    primaryColor: Color.fromARGB(195, 129, 73, 188),
    secondaryHeaderColor: const Color.fromARGB(15, 198, 15, 103),
    useMaterial3: true,
    // scaffoldBackgroundColor: Colors.white,
    colorScheme: ThemeData().colorScheme.copyWith(
          primary: const Color.fromARGB(195, 62, 27, 100),
          secondary: const Color.fromARGB(15, 198, 15, 103),
          background: const Color.fromARGB(255, 165, 170, 177),
        ),
    fontFamily: 'Stick No Bills',
    // ignore: prefer_const_constructors
    // textTheme: TextTheme(
    //   // ignore: prefer_const_constructors
    //   displayLarge: TextStyle(
    //     // ignore: prefer_const_constructors
    //     color: Colors.white,
    //     fontWeight: FontWeight.bold,
    //     fontSize: 36,
    //   ),
    //   displayMedium: const TextStyle(
    //     // ignore: prefer_const_constructors
    //     color: Colors.white,
    //     fontWeight: FontWeight.bold,
    //     fontSize: 24,
    //   ),

    //   displaySmall: const TextStyle(
    //     // ignore: prefer_const_constructors
    //     color: Colors.white,
    //     fontWeight: FontWeight.bold,
    //     fontSize: 18,
    //   ),

    //   headlineMedium: const TextStyle(
    //     // ignore: prefer_const_constructors
    //     color: Colors.white,
    //     fontWeight: FontWeight.bold,
    //     fontSize: 16,
    //   ),

    //   headlineSmall: const TextStyle(
    //     // ignore: prefer_const_constructors
    //     color: Colors.white,
    //     fontWeight: FontWeight.bold,
    //     fontSize: 14,
    //   ),

    //   titleLarge: const TextStyle(
    //     // ignore: prefer_const_constructors
    //     color: Colors.white,
    //     fontWeight: FontWeight.normal,
    //     fontSize: 14,
    //   ),

    //   bodyLarge: const TextStyle(
    //     // ignore: prefer_const_constructors
    //     color: Colors.white,
    //     fontWeight: FontWeight.normal,
    //     fontSize: 12,
    //   ),
    //   bodyMedium: const TextStyle(
    //     // ignore: prefer_const_constructors
    //     color: Colors.white,
    //     fontWeight: FontWeight.normal,
    //     fontSize: 10,
    //   ),
    //   bodySmall: const TextStyle(
    //     // ignore: prefer_const_constructors
    //     color: Colors.white,
    //     fontWeight: FontWeight.normal,
    //     fontSize: 8,
    //   ),
    // ),
  );
}
