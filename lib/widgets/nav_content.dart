// lib/widgets/nav_content.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_type.dart';
import '../providers/theme_provider.dart';

class NavContent extends StatelessWidget {
  final String currentRouteName;
  final UserType userType;

  const NavContent({
    super.key,
    required this.currentRouteName,
    this.userType = UserType.client, 
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDarkMode = context.watch<ThemeProvider>().themeMode == ThemeMode.dark;
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // --- PARTNER SECTION ---
        if (userType != UserType.client) ...[
          Container(
            padding: const EdgeInsets.only(bottom: 16),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: theme.dividerColor)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Meu Negócio',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                _buildNavItem(context, Icons.dashboard, 'Dashboard', routeName: '/dashboard', currentRoute: currentRouteName, isSpecial: true),
                _buildNavItem(context, Icons.campaign, 'Anúncios Patrocinados', routeName: '/ads', currentRoute: currentRouteName),
                if (userType == UserType.provider)
                  _buildNavItem(context, Icons.inventory_2, 'Gerenciar Produtos', routeName: '/manage-products', currentRoute: currentRouteName),
                if (userType == UserType.ngo)
                  _buildNavItem(context, Icons.volunteer_activism, 'Gerenciar Campanhas', routeName: '/manage-campaigns', currentRoute: currentRouteName),
              ],
            ),
          ),
        ],

        // --- STANDARD MENU ---
        _buildNavItem(context, Icons.home_outlined, 'Página Inicial', routeName: '/timeline', currentRoute: currentRouteName),
        _buildNavItem(context, Icons.business_outlined, 'ONGs', routeName: '/ongs', currentRoute: currentRouteName),
        _buildNavItem(context, Icons.favorite_border, 'Adoção', routeName: '/adocao', currentRoute: currentRouteName),
        _buildNavItem(context, Icons.store_outlined, 'Serviços', routeName: '/servicos', currentRoute: currentRouteName),
        _buildNavItem(context, Icons.shopping_bag_outlined, 'Marketplace', routeName: '/marketplace', currentRoute: currentRouteName),
        
        const Divider(height: 30),
        const Text('Comunidade', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _buildNavItem(context, Icons.explore_outlined, 'Explorar', routeName: '/explorar', currentRoute: currentRouteName),
        _buildNavItem(context, Icons.people_outline, 'Amigos', routeName: '/amigos', currentRoute: currentRouteName),
        _buildNavItem(context, Icons.group_outlined, 'Grupos', routeName: '/grupos', currentRoute: currentRouteName),
        
        const Divider(height: 30),
        const Text('Conta', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _buildNavItem(context, Icons.report_problem_outlined, 'Relatar problema', routeName: '/problema', currentRoute: currentRouteName),
        _buildNavItem(context, Icons.history, 'Sua atividade', routeName: '/atividade', currentRoute: currentRouteName),
        
        SwitchListTile(
          contentPadding: const EdgeInsets.only(left: 16, right: 8),
          title: const Text('Modo de exibição'),
          value: isDarkMode,
          onChanged: (value) {
            themeProvider.setTheme(value ? ThemeMode.dark : ThemeMode.light);
          },
          secondary: Icon(isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined),
        ),
      ],
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String title, {
    required String routeName,
    required String currentRoute,
    bool isSpecial = false, 
  }) {
    final isSelected = (routeName == currentRoute);
    final colorScheme = Theme.of(context).colorScheme;
    final isMobile = MediaQuery.of(context).size.width < 800;

    return ListTile(
      leading: Icon(
        icon, 
        color: isSelected || isSpecial ? colorScheme.primary : colorScheme.onSurfaceVariant
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected || isSpecial ? FontWeight.bold : FontWeight.normal,
          color: isSelected || isSpecial ? colorScheme.primary : colorScheme.onSurface,
        ),
      ),
      onTap: () {
        if (isSelected && isMobile) {
          Navigator.pop(context);
          return;
        }
        if (isSelected && !isMobile) return;
        
        // UPDATED: Pass userType as argument to the next route!
        Navigator.pushReplacementNamed(
          context, 
          routeName, 
          arguments: userType // <--- THIS IS THE KEY
        );
      },
      selected: isSelected,
      selectedTileColor: colorScheme.primary.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}