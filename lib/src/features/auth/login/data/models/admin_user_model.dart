import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:admin_msar/src/features/auth/login/domain/entities/admin_user.dart';

class AdminUserModel {
  const AdminUserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.role,
  });

  final String uid;
  final String email;
  final String name;
  final String role;

  factory AdminUserModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? const {};
    return AdminUserModel(
      uid: doc.id,
      email: (data['email'] ?? '') as String,
      name: (data['name'] ?? '') as String,
      role: (data['role'] ?? 'user') as String,
    );
  }

  AdminUser toEntity() =>
      AdminUser(uid: uid, email: email, name: name, role: role);
}
