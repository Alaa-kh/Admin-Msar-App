import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:admin_msar/src/features/auth/login/data/models/admin_user_model.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
  }) : _auth = firebaseAuth,
       _firestore = firestore;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _users =>
      _firestore.collection('users');

  Future<AdminUserModel> signIn({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final uid = credential.user!.uid;
    final doc = await _users.doc(uid).get();
    if (!doc.exists) {
      throw FirebaseAuthException(
        code: 'user-not-found',
        message: 'لا يوجد ملف مستخدم لهذا الحساب',
      );
    }
    return AdminUserModel.fromDoc(doc);
  }

  Future<void> signOut() => _auth.signOut();

  Future<AdminUserModel?> getCurrentAdmin() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    final doc = await _users.doc(user.uid).get();
    if (!doc.exists) return null;
    return AdminUserModel.fromDoc(doc);
  }

  Stream<AdminUserModel?> authStateChanges() {
    return _auth.authStateChanges().asyncMap((user) async {
      if (user == null) return null;
      final doc = await _users.doc(user.uid).get();
      if (!doc.exists) return null;
      return AdminUserModel.fromDoc(doc);
    });
  }
}
