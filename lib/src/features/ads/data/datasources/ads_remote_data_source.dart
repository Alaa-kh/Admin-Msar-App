import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:admin_msar/src/features/ads/data/models/banner_ad_model.dart';

class AdsRemoteDataSource {
  AdsRemoteDataSource({
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
  }) : _firestore = firestore,
       _storage = storage;

  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  CollectionReference<Map<String, dynamic>> get _banners =>
      _firestore.collection('banners');

  Future<List<BannerAdModel>> getAds() async {
    final snapshot = await _banners.orderBy('order').get();
    return snapshot.docs.map(BannerAdModel.fromDoc).toList();
  }

  Future<void> deleteAd(String id) async {
    final doc = await _banners.doc(id).get();
    final data = doc.data();
    if (data != null) {
      final path = data['storagePath'] as String?;
      if (path != null && path.isNotEmpty) {
        try {
          await _storage.ref(path).delete();
        } on FirebaseException {
          // Ignore if the file is already missing — Firestore doc is the source of truth.
        }
      }
    }
    await _banners.doc(id).delete();
  }

  Future<BannerAdModel> createAd({required File image}) async {
    final aggregate = await _banners.count().get();
    final nextOrder = (aggregate.count ?? 0) + 1;
    final docRef = _banners.doc();
    final storagePath =
        'banners/${docRef.id}_${DateTime.now().millisecondsSinceEpoch}.jpg';

    final uploadTask = await _storage.ref(storagePath).putFile(image);
    final imageUrl = await uploadTask.ref.getDownloadURL();

    await docRef.set({
      'imageUrl': imageUrl,
      'isActive': true,
      'order': nextOrder,
      'storagePath': storagePath,
      'createdAt': FieldValue.serverTimestamp(),
    });
    final snapshot = await docRef.get();
    return BannerAdModel.fromDoc(snapshot);
  }

  Stream<int> adsCount() =>
      _banners.snapshots().map((snap) => snap.docs.length);
}
