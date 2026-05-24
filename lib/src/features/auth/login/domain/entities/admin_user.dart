class AdminUser {
  const AdminUser({
    required this.uid,
    required this.email,
    required this.name,
    required this.role,
  });

  final String uid;
  final String email;
  final String name;
  final String role;

  bool get isAdmin => role == 'admin';
}
