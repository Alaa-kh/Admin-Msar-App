import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:admin_msar/src/features/users/data/models/app_user_model.dart';

class UsersRemoteDataSource {
  UsersRemoteDataSource(this._firestore);
  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _users =>
      _firestore.collection('users');

  Future<List<AppUserModel>> getUsers() async {
    final snapshot = await _users.orderBy('createdAt', descending: true).get();
    return snapshot.docs.map(AppUserModel.fromDoc).toList();
  }

  Future<void> deleteUser(String id) => _users.doc(id).delete();

  Stream<int> usersCount() =>
      _users.snapshots().map((snap) => snap.docs.length);
}
