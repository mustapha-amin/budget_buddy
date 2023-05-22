import 'package:budget_buddy/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:budget_buddy/database/hive_db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

HiveService hiveService = HiveService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await hiveService.initializeDB();
  runApp(
    ChangeNotifierProvider(
      create: (context) => hiveService,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const BottomNavBar(),
        theme: ThemeData(
          useMaterial3: true,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: Colors.black,
          ),
          segmentedButtonTheme: SegmentedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.black;
                  }
                  return Colors.white;
                },
              ),
              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.white;
                  }
                  return Colors.black;
                },
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
