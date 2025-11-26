// lib/widgets/nav_drawer.dart

import 'package:flutter/material.dart';
import '../models/user_type.dart';
import 'nav_content.dart';

class NavDrawer extends StatelessWidget {
  final String currentRouteName;
  final UserType userType;

  const NavDrawer({
    super.key, 
    required this.currentRouteName, 
    required this.userType
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: NavContent(currentRouteName: currentRouteName, userType: userType),
    );
  }
}