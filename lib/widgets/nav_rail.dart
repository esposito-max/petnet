// lib/widgets/nav_rail.dart

import 'package:flutter/material.dart';
import '../models/user_type.dart';
import 'nav_content.dart';

class NavRail extends StatelessWidget {
  final String currentRouteName;
  final UserType userType;

  const NavRail({
    super.key, 
    required this.currentRouteName, 
    required this.userType
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: NavContent(currentRouteName: currentRouteName, userType: userType),
    );
  }
}