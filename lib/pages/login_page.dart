// lib/pages/login_page.dart

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../data/mock_database.dart';
import '../models/user_model.dart';
import '../widgets/image_panel.dart';
import '../widgets/main_shell.dart';
import 'timeline_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 768) {
            return Center(child: _buildDesktopLayout());
          } else {
            return _buildMobileLayout(constraints);
          }
        },
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 1000, maxHeight: 700),
      margin: const EdgeInsets.all(24),
      child: Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        clipBehavior: Clip.antiAlias,
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(flex: 2, child: LoginForm(isMobile: false)),
            Expanded(flex: 3, child: ImagePanel()),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BoxConstraints constraints) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset('assets/pug_image.png', fit: BoxFit.cover),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF4C87B9).withOpacity(0.85),
                const Color(0xFF6EE087).withOpacity(0.85),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
              child: LoginForm(isMobile: true),
            ),
          ),
        ),
      ],
    );
  }
}

class LoginForm extends StatefulWidget {
  final bool isMobile;
  const LoginForm({super.key, this.isMobile = false});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dbService = MockDatabaseService();
  
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final User? user = await _dbService.login(email, password);

    setState(() {
      _isLoading = false;
    });

    if (user != null && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainShell(
            currentRouteName: '/timeline',
            userType: user.userType, 
            child: const TimelinePage(),
          ),
        ),
      );
    } else {
      setState(() {
        _errorMessage = "Email ou senha incorretos.";
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.isMobile ? EdgeInsets.zero : const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
      decoration: widget.isMobile
          ? null
          : const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4C87B9), Color(0xFF6EE087)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/petnet_logo.jpeg', height: 32),
          const SizedBox(height: 30),
          const Text('Bem-vindo\nde volta', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold, height: 1.2)),
          const SizedBox(height: 10),
          const Text('Estamos felizes em te ver.', style: TextStyle(color: Colors.white, fontSize: 16)),
          const SizedBox(height: 30),
          
          TextField(
            controller: _emailController,
            style: const TextStyle(color: Colors.black), // FIXED: Explicit text color
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon: const Icon(Icons.email, color: Colors.black54),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 20),
          
          TextField(
            controller: _passwordController,
            obscureText: true,
            style: const TextStyle(color: Colors.black), // FIXED: Explicit text color
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _handleLogin(), // FIXED: Enter key works now
            decoration: InputDecoration(
              hintText: 'Senha',
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon: const Icon(Icons.lock, color: Colors.black54),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
          
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
              ),
            ),

          const SizedBox(height: 30),
          
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4C87B9),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: _isLoading 
                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                : const Text('ENTRAR', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
          
          const SizedBox(height: 20),
          
          Center(
            child: Text.rich(
              TextSpan(
                text: 'Não tem uma conta? ',
                style: const TextStyle(color: Colors.white),
                children: [
                  TextSpan(
                    text: 'Crie uma',
                    style: const TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline, color: Colors.white),
                    recognizer: TapGestureRecognizer()..onTap = () => Navigator.pushNamed(context, '/signup'),
                  )
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),
          const Divider(color: Colors.white54),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'Quer ser um parceiro?',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/signup-ngo'),
                style: TextButton.styleFrom(foregroundColor: Colors.white),
                child: const Text(
                  'Sou uma ONG',
                  style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.bold),
                ),
              ),
              const Text('|', style: TextStyle(color: Colors.white54)),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/signup-provider'),
                style: TextButton.styleFrom(foregroundColor: Colors.white),
                child: const Text(
                  'Sou Profissional',
                  style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}