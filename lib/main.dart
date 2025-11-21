import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marinuata_app/firebase_options.dart';

// Imports das Telas
import 'package:marinuata_app/screens/login_screen.dart';
// Se a pasta estiver diferente, ajuste este import:
import 'package:marinuata_app/screens/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase com as configurações geradas
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ProviderScope é OBRIGATÓRIO para o Riverpod funcionar
  runApp(const ProviderScope(child: MarinuataApp()));
}

class MarinuataApp extends StatelessWidget {
  const MarinuataApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marinuata',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00294D)),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.grey[50],
        ),
      ),
      // O StreamBuilder ouve o Firebase:
      // - Se tem usuário -> DashboardScreen
      // - Se não tem -> LoginScreen
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }

          if (snapshot.hasData) {
            return const DashboardScreen();
          }

          return const LoginScreen();
        },
      ),
    );
  }
}
