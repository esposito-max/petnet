// lib/pages/signup_provider_page.dart

import 'package:flutter/material.dart';
import '../widgets/partner_auth_shell.dart';

class SignupProviderPage extends StatelessWidget {
  const SignupProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PartnerAuthShell(
      imagePath: 'assets/cat.jpeg', 
      formChildren: [
        // Logo
        Row(
          children: [
            // Assuming you want the logo to look like the one in the image (icon + text)
            // If you have the asset, swap Icon for Image.asset('assets/petnet_logo.png')
            const Icon(Icons.pets, color: Colors.white, size: 32),
            const SizedBox(width: 8),
            const Text(
              'petnet',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        
        // Header Text
        const Text(
          'Seja bem-vindo\nao PetNet!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Estamos felizes em receber seu serviço em nossa rede! Vamos fazer o seu cadastro?',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(height: 30),

        // Form Fields
        _buildTextField('Nome do serviço'),
        const SizedBox(height: 16),
        _buildTextField('CNPJ'),
        const SizedBox(height: 16),
        _buildTextField('Endereço'),
        const SizedBox(height: 16),
        _buildTextField('Telefone para contato'),
        const SizedBox(height: 16),
        _buildTextField('Seu nome completo'),
        const SizedBox(height: 16),
        _buildTextField('Qual o seu serviço prestado?'),
        
        const SizedBox(height: 30),

        // Submit Button
        SizedBox(
          width: double.infinity,
          height: 50, // Taller button to match design
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6EE087), // The Green from the design
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'CADASTRAR', // Uppercase match
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text.rich(
              TextSpan(
                text: 'Já tem uma conta? ',
                style: TextStyle(color: Colors.white),
                children: [
                  TextSpan(
                    text: 'Entre',
                    style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String hint) {
    return TextField(
      style: const TextStyle(color: Colors.black), // Ensure text is black
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white, // White background
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none, // Remove border lines
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}