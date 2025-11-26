// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/user_type.dart'; // Import Enum
import 'providers/theme_provider.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/signup_provider_page.dart';
import 'pages/signup_ngo_page.dart';
import 'pages/timeline_page.dart';
import 'pages/marketplace_page.dart';
import 'pages/servicos_page.dart';
import 'pages/ongs_page.dart';
import 'pages/adocao_page.dart';
import 'pages/dashboard_page.dart';
import 'widgets/main_shell.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color primaryColor = Color(0xFF508CBB);
  static const Color accentColorPink = Color(0xFFEA5B6A);
  static const Color accentColorGreen = Color(0xFF60D67A);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Petnet App',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: primaryColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.light,
          secondary: accentColorGreen,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: primaryColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.dark,
          secondary: accentColorGreen,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      // We keep the static routes for auth pages
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/signup-ngo': (context) => const SignupNGOPage(),
        '/signup-provider': (context) => const SignupProviderPage(),
      },
      // We use onGenerateRoute for dynamic pages that need UserType
      onGenerateRoute: (settings) {
        // Extract the UserType argument passed from Navigator
        // If no argument is passed (e.g. during dev), default to client
        final UserType userType = (settings.arguments as UserType?) ?? UserType.client;

        switch (settings.name) {
          case '/timeline':
            return MaterialPageRoute(
              builder: (_) => MainShell(
                currentRouteName: '/timeline',
                userType: userType,
                child: const TimelinePage(),
              ),
            );
          case '/marketplace':
            return MaterialPageRoute(
              builder: (_) => MainShell(
                currentRouteName: '/marketplace',
                userType: userType,
                child: const MarketplacePage(),
              ),
            );
          case '/adocao':
            return MaterialPageRoute(
              builder: (_) => MainShell(
                currentRouteName: '/adocao',
                userType: userType,
                child: const AdocaoPage(),
              ),
            );
          case '/servicos':
            return MaterialPageRoute(
              builder: (_) => MainShell(
                currentRouteName: '/servicos',
                userType: userType,
                child: const ServicosPage(),
              ),
            );
          case '/ongs':
            return MaterialPageRoute(
              builder: (_) => MainShell(
                currentRouteName: '/ongs',
                userType: userType,
                child: const ONGsPage(),
              ),
            );
          case '/dashboard':
            return MaterialPageRoute(
              builder: (_) => MainShell(
                currentRouteName: '/dashboard',
                userType: userType,
                child: DashboardPage(userType: userType), // Pass type to dashboard too
              ),
            );
          // Placeholders
          case '/explorar':
            return MaterialPageRoute(builder: (_) => MainShell(currentRouteName: '/explorar', userType: userType, child: const Center(child: Text('Explorar Page'))));
          case '/amigos':
            return MaterialPageRoute(builder: (_) => MainShell(currentRouteName: '/amigos', userType: userType, child: const Center(child: Text('Amigos Page'))));
          case '/grupos':
            return MaterialPageRoute(builder: (_) => MainShell(currentRouteName: '/grupos', userType: userType, child: const Center(child: Text('Grupos Page'))));
          case '/problema':
            return MaterialPageRoute(builder: (_) => MainShell(currentRouteName: '/problema', userType: userType, child: const Center(child: Text('Relatar Problema Page'))));
          case '/atividade':
            return MaterialPageRoute(builder: (_) => MainShell(currentRouteName: '/atividade', userType: userType, child: const Center(child: Text('Sua Atividade Page'))));
          case '/ads':
            return MaterialPageRoute(builder: (_) => MainShell(currentRouteName: '/ads', userType: userType, child: const Center(child: Text('Comprar Anúncios'))));
          case '/manage-products':
            return MaterialPageRoute(builder: (_) => MainShell(currentRouteName: '/manage-products', userType: userType, child: const Center(child: Text('Gerenciar Produtos'))));
          case '/manage-campaigns':
            return MaterialPageRoute(builder: (_) => MainShell(currentRouteName: '/manage-campaigns', userType: userType, child: const Center(child: Text('Gerenciar Campanhas'))));
          
          default:
            return null; // Let Flutter handle unknown routes
        }
      },
    );
  }
}