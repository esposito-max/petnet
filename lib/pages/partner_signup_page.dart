// lib/pages/partner_signup_page.dart

import 'package:flutter/material.dart';

class PartnerSignupPage extends StatelessWidget {
  final String title;
  final String userType; // 'ngo' or 'provider'

  const PartnerSignupPage({
    super.key,
    required this.title,
    required this.userType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFFF5F5F5),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                userType == 'ngo' ? Icons.business : Icons.work,
                size: 80,
                color: userType == 'ngo' ? const Color(0xFF508CBB) : const Color(0xFF60D67A),
              ),
              const SizedBox(height: 20),
              Text(
                'Cadastro de $title',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Formulário específico para parceiros em construção.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Voltar para Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}