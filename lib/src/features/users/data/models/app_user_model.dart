import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:admin_msar/src/features/users/domain/entities/app_user.dart';

class AppUserModel {
  const AppUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.createdAt,
  });

  final String id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final DateTime? createdAt;

  factory AppUserModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? const {};
    return AppUserModel(
      id: doc.id,
      name: (data['name'] ?? '') as String,
      email: (data['email'] ?? '') as String,
      phone: (data['phone'] ?? '') as String,
      role: (data['role'] ?? 'user') as String,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  AppUser toEntity() => AppUser(
    id: id,
    name: name,
    email: email,
    phone: phone,
    role: role,
    createdAt: createdAt,
  );
}
