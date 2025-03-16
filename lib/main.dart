import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kohab/core/theme/theme_provider.dart';
import 'package:kohab/features/auth/presentation/pages/login_page.dart';
import 'package:kohab/features/habits/presentation/blocs/habits_cubit.dart';
import 'package:kohab/features/home/presentation/pages/home_page.dart';
import 'package:kohab/service_locator.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  String supabaseUrl = dotenv.env['supabaseUrl'] ?? '';
  String supabaseKey = dotenv.env['supabaseKey'] ?? '';
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HabitsCubit()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var session = sl<SupabaseClient>().auth.currentSession;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: session != null ? const HomePage() : const LoginPage(),
    );
  }
}
