//import 'package:app03/models/expense.dart
import 'package:app03/widgets/expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Add this line

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then(
    (_) => runApp(const MyApp()),
  );
}

var myColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 59, 96, 179));

var mydarkColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 59, 96, 179));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      theme: ThemeData().copyWith(
          // useMaterial3: true,
          colorScheme: myColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: myColorScheme.onPrimaryContainer,
            foregroundColor: myColorScheme.primaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(
            color: myColorScheme.secondaryContainer,
          ),
          // margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: myColorScheme.primaryContainer,
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith()),
      darkTheme: ThemeData.dark().copyWith(
          //useMaterial3: true,
          colorScheme: mydarkColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: mydarkColorScheme.onPrimaryContainer,
            foregroundColor: mydarkColorScheme.primaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(
              color: mydarkColorScheme.secondaryContainer,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: mydarkColorScheme.primaryContainer,
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith()),
      home: const Expenses(),
      debugShowCheckedModeBanner: false,
    );
  }
}
