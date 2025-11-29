// lib/data/mock_database.dart

import '../models/category_model.dart';
import '../models/ngo_model.dart';
import '../models/pet_model.dart';
import '../models/post_model.dart';
import '../models/product_model.dart';
import '../models/user_model.dart';
import '../models/user_type.dart';

// Model for service filter chips
class ServiceFilter {
  final String id;
  final String name;
  const ServiceFilter({required this.id, required this.name});
}

class MockDatabaseService {
  // ==============================================================================
  // 1. MOCK USERS & AUTHENTICATION
  // ==============================================================================

  final List<User> _users = [
    // CLIENT
    const User(
      id: 'client_01',
      name: 'Sofia Morgado',
      email: 'morgado@email.com',
      password: '#Morgado', 
      profileImageUrl: 'assets/morgado.jpg',
      userType: UserType.client,
    ),
    // SERVICE PROVIDER
    const User(
      id: 'provider_01',
      name: 'PetShop Legal',
      email: 'shop@email.com',
      password: 'pass_serv',
      profileImageUrl: 'https://images.unsplash.com/photo-1556740738-b6a63e27c4df?ixlib=rb-4.0.3&auto=format&fit=crop&w=1770&q=80',
      userType: UserType.provider,
    ),
    // NGO
    const User(
      id: 'ngo_01',
      name: 'ONG Patinhas',
      email: 'ong@email.com',
      password: 'pass_ngo',
      profileImageUrl: 'https://images.unsplash.com/photo-1532629345422-7515f3d16bb6?ixlib=rb-4.0.3&auto=format&fit=crop&w=1770&q=80',
      userType: UserType.ngo,
    ),
  ];

  /// Validates email and password. Returns the User object if successful, null otherwise.
  Future<User?> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network request
    try {
      final user = _users.firstWhere(
        (u) => u.email == email && u.password == password,
      );
      return user;
    } catch (e) {
      return null;
    }
  }

  // ==============================================================================
  // 2. TIMELINE DATA (POSTS)
  // ==============================================================================

  late final List<Post> _posts;

  MockDatabaseService() {
    _posts = [
      Post(
        id: 'post_01',
        author: _users[0], // Ana
        text: 'Dia de levar a princesa para passear! 🐕',
        imageUrl: 'https://images.unsplash.com/photo-1537151608828-ea2b11777ee8?ixlib=rb-4.0.3&auto=format&fit=crop&w=394&q=80',
        timestamp: DateTime.now().subtract(const Duration(minutes: 6)),
      ),
      Post(
        id: 'post_02',
        author: _users[1], // PetShop
        text: 'Bom dia, rede! Estamos com promoção de banho e tosa hoje. Agende já!',
        timestamp: DateTime.now().subtract(const Duration(minutes: 11)),
      ),
      Post(
        id: 'post_03',
        author: _users[2], // ONG
        text: 'Precisamos de doações de ração para nossos 50 gatinhos resgatados. Qualquer ajuda é bem-vinda!',
        imageUrl: 'https://images.unsplash.com/photo-1548681528-6a5c45b66b42?ixlib=rb-4.0.3&auto=format&fit=crop&w=387&q=80',
        timestamp: DateTime.now().subtract(const Duration(minutes: 18)),
      ),
    ];
  }

  Future<List<Post>> getFeedPosts() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _posts;
  }

  // ==============================================================================
  // 3. MARKETPLACE & SERVICES DATA
  // ==============================================================================

  final List<Product> _products = [
    const Product(id: 'p1', name: 'Coleira personalizada', brand: 'Petz', price: 49.99, imageUrl: 'https://via.placeholder.com/150/FF8C00/FFFFFF?Text=Coleira'),
    const Product(id: 'p2', name: 'Petisco Premium', brand: 'Whiskas', price: 19.99, imageUrl: 'https://via.placeholder.com/150/4682B4/FFFFFF?Text=Petisco'),
    const Product(id: 'p3', name: 'Cama Nuvem', brand: 'Fábrica Pet', price: 129.90, imageUrl: 'https://via.placeholder.com/150/32CD32/FFFFFF?Text=Cama'),
    const Product(id: 'p4', name: 'Ração Gourmet', brand: 'Royal Canin', price: 89.90, imageUrl: 'https://via.placeholder.com/150/DC143C/FFFFFF?Text=Racao'),
  ];

  final List<Category> _dogCategories = [
    const Category(id: 'dc1', name: 'Anti-pulgas', imageUrl: 'https://via.placeholder.com/80/87CEEB/FFFFFF?Text=AntiPulga'),
    const Category(id: 'dc2', name: 'Roupas', imageUrl: 'https://via.placeholder.com/80/FFA07A/FFFFFF?Text=Roupas'),
    const Category(id: 'dc3', name: 'Coleiras', imageUrl: 'https://via.placeholder.com/80/FFD700/FFFFFF?Text=Coleiras'),
  ];

  final List<Category> _catCategories = [
    const Category(id: 'cc1', name: 'Arranhadores', imageUrl: 'https://via.placeholder.com/80/BA55D3/FFFFFF?Text=Arranhador'),
    const Category(id: 'cc2', name: 'Areias', imageUrl: 'https://via.placeholder.com/80/7FFFD4/FFFFFF?Text=Areia'),
  ];

  final List<ServiceFilter> _serviceFilters = [
    const ServiceFilter(id: 's1', name: 'Banho e tosa'),
    const ServiceFilter(id: 's2', name: 'Veterinário'),
    const ServiceFilter(id: 's3', name: 'Pet Sitter'),
    const ServiceFilter(id: 's4', name: 'Adestramento'),
    const ServiceFilter(id: 's5', name: 'Hotelzinho'),
  ];

  Future<List<Product>> getRecommendedProducts() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _products;
  }

  Future<List<Category>> getDogCategories() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _dogCategories;
  }

  Future<List<Category>> getCatCategories() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _catCategories;
  }

  Future<List<ServiceFilter>> getServiceFilters() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _serviceFilters;
  }

  // ==============================================================================
  // 4. ADOPTION & NGO DATA
  // ==============================================================================

  final List<Pet> _pets = [
    const Pet(id: 'pet1', name: 'Abely', imageUrl: 'https://via.placeholder.com/300/FFD700/000000?Text=Abely', associationName: 'Associação Focinho', location: 'Mooca, SP', gender: 'female'),
    const Pet(id: 'pet2', name: 'Billy', imageUrl: 'https://via.placeholder.com/300/ADFF2F/000000?Text=Billy', associationName: 'ONG Patinhas', location: 'Rio Claro, SP', gender: 'male'),
    const Pet(id: 'pet3', name: 'Amora', imageUrl: 'https://via.placeholder.com/300/FF69B4/000000?Text=Amora', associationName: 'Associação Focinho', location: 'Cuiabá, MT', gender: 'female'),
    const Pet(id: 'pet4', name: 'Thor', imageUrl: 'https://via.placeholder.com/300/87CEEB/000000?Text=Thor', associationName: 'Amigos do Bem', location: 'Centro, SP', gender: 'male'),
  ];

  final List<NGO> _ngos = [
    NGO(id: 'n1', name: 'Associação Amigos', logoUrl: 'https://via.placeholder.com/100/FFD700/000000?Text=NGO1', lastActionTimestamp: DateTime.now().subtract(const Duration(hours: 1))),
    NGO(id: 'n2', name: 'Vira Lata Feliz', logoUrl: 'https://via.placeholder.com/100/ADFF2F/000000?Text=NGO2', lastActionTimestamp: DateTime.now().subtract(const Duration(minutes: 20))),
    NGO(id: 'n3', name: 'Gatinhos da Praça', logoUrl: 'https://via.placeholder.com/100/FF69B4/000000?Text=NGO3', lastActionTimestamp: DateTime.now().subtract(const Duration(days: 2))),
    NGO(id: 'n4', name: 'Cão Sem Dono', logoUrl: 'https://via.placeholder.com/100/87CEEB/000000?Text=NGO4', lastActionTimestamp: DateTime.now().subtract(const Duration(hours: 5))),
  ];

  Future<List<Pet>> getAdoptablePets() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _pets;
  }

  Future<List<NGO>> getNGOsSortedByActivity() async {
    await Future.delayed(const Duration(milliseconds: 700));
    _ngos.sort((a, b) => b.lastActionTimestamp.compareTo(a.lastActionTimestamp));
    return _ngos;
  }
}