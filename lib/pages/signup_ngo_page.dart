// lib/pages/signup_ngo_page.dart

import 'package:flutter/material.dart';
import '../widgets/partner_auth_shell.dart';

class SignupNGOPage extends StatelessWidget {
  const SignupNGOPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PartnerAuthShell(
      imagePath: 'assets/macaw.jpg', 
      formChildren: [
        // Logo
        Row(
          children: [
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
          'Estamos felizes em apoiar a sua causa! Vamos fazer o cadastro da sua ONG?',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(height: 30),

        // Form Fields
        _buildTextField('Nome da ONG'),
        const SizedBox(height: 16),
        _buildTextField('CNPJ'),
        const SizedBox(height: 16),
        _buildTextField('Endereço da Sede'),
        const SizedBox(height: 16),
        _buildTextField('Telefone para contato'),
        const SizedBox(height: 16),
        _buildTextField('Nome do Representante'),
        const SizedBox(height: 16),
        _buildTextField('Área de atuação'),
        
        const SizedBox(height: 30),

        // Submit Button
        SizedBox(
          width: double.infinity,
          height: 50,
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
              'CADASTRAR',
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
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}