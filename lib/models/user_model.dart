// lib/models/user_model.dart
import 'user_type.dart';

class User {
  final String id;
  final String name;
  final String email;    // Added
  final String password; // Added
  final String profileImageUrl;
  final UserType userType;

  const User({
    required this.id,
    required this.name,
    required this.email,    // Added
    required this.password, // Added
    required this.profileImageUrl,
    required this.userType,
  });
}