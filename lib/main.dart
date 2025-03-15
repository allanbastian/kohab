import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kohab/database/habit_database.dart';
import 'package:kohab/features/home/presentation/pages/home_page.dart';
import 'package:kohab/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'dotenv');
  String supabaseUrl = dotenv.env['supabaseUrl'] ?? '';
  String supabaseKey = dotenv.env['supabaseKey'] ?? '';
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  await HabitDatabase.initialize();
  await HabitDatabase().saveFirstLaunchDate();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => HabitDatabase()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const HomePage(),
      // home: const LoginPage(),
    );
  }
}
