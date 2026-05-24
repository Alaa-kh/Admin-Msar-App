import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:admin_msar/src/features/posts/data/models/post_model.dart';
import 'package:admin_msar/src/features/posts/domain/entities/post.dart';
import 'package:admin_msar/src/features/posts/domain/repositories/posts_repository.dart';

class PostsRemoteDataSource {
  PostsRemoteDataSource(this._firestore);
  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _posts =>
      _firestore.collection('opportunities');

  Future<List<PostModel>> getPosts() async {
    final snapshot = await _posts.orderBy('createdAt', descending: true).get();
    return snapshot.docs.map(PostModel.fromDoc).toList();
  }

  Future<void> deletePost(String id) => _posts.doc(id).delete();

  Future<PostModel> createPost(CreatePostParams params) async {
    final docRef = _posts.doc();
    final payload = <String, dynamic>{
      'title': params.title,
      'description': params.description,
      'whatsapp': params.whatsapp,
      'audience': postAudienceToString(params.audience),
      'isActive': true,
      'company': params.company,
      'city': params.city,
      'createdAt': FieldValue.serverTimestamp(),
    };
    await docRef.set(payload);
    final snapshot = await docRef.get();
    return PostModel.fromDoc(snapshot);
  }

  Stream<int> postsCount() =>
      _posts.snapshots().map((snap) => snap.docs.length);
}
