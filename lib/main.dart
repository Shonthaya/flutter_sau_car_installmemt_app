import 'package:flutter/material.dart';
import 'package:flutter_sau_car_installmemt_app/car_cal.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const FlutterSauCarInstallmemetApp());
}

// ================================================
class FlutterSauCarInstallmemetApp extends StatefulWidget {
  const FlutterSauCarInstallmemetApp({super.key});

  @override
  State<FlutterSauCarInstallmemetApp> createState() =>
      _FlutterSauCarInstallmemetAppState();
}

class _FlutterSauCarInstallmemetAppState
    extends State<FlutterSauCarInstallmemetApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CarCal(),
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
    );
  }
}
