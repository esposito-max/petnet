// lib/widgets/partner_auth_shell.dart

import 'package:flutter/material.dart';

class PartnerAuthShell extends StatelessWidget {
  final String imagePath;
  final List<Widget> formChildren;

  const PartnerAuthShell({
    super.key,
    required this.imagePath,
    required this.formChildren,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light grey background like Login/Signup
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 768) {
            return _buildDesktopLayout(context);
          } else {
            return _buildMobileLayout(context);
          }
        },
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Center(
      child: Container(
        // Constraints to match the Login/Signup card size (slightly taller for longer forms)
        constraints: const BoxConstraints(maxWidth: 1000, maxHeight: 800),
        margin: const EdgeInsets.all(24),
        child: Card(
          elevation: 8.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          clipBehavior: Clip.antiAlias,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left Side: Form (with Gradient)
              Expanded(
                flex: 3, // Giving more space to the form as partners have more fields
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF6EE087), Color(0xFF4C87B9)], // Green to Blue (Top to Bottom)
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: formChildren,
                      ),
                    ),
                  ),
                ),
              ),
              // Right Side: Image
              Expanded(
                flex: 2, 
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter, 
                  errorBuilder: (c, e, s) => Container(
                    color: Colors.white, 
                    child: const Center(child: Icon(Icons.image, size: 50, color: Colors.grey)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background Image
        Image.asset(
          imagePath,
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
          errorBuilder: (c, e, s) => Container(color: Colors.grey),
        ),
        // Gradient Overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF6EE087).withOpacity(0.9),
                const Color(0xFF4C87B9).withOpacity(0.9),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        // Scrollable Form
        Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: formChildren,
            ),
          ),
        ),
      ],
    );
  }
}