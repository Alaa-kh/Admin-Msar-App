import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:admin_msar/src/features/ads/data/models/banner_ad_model.dart';

class AdsRemoteDataSource {
  AdsRemoteDataSource(this._firestore);
  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _banners =>
      _firestore.collection('banners');

  Future<List<BannerAdModel>> getAds() async {
    final snapshot = await _banners.orderBy('order').get();
    return snapshot.docs.map(BannerAdModel.fromDoc).toList();
  }

  Future<void> deleteAd(String id) => _banners.doc(id).delete();

  Future<BannerAdModel> createAd({required String imageUrl}) async {
    final aggregate = await _banners.count().get();
    final nextOrder = (aggregate.count ?? 0) + 1;
    final docRef = _banners.doc();
    await docRef.set({
      'imageUrl': imageUrl,
      'isActive': true,
      'order': nextOrder,
      'createdAt': FieldValue.serverTimestamp(),
    });
    final snapshot = await docRef.get();
    return BannerAdModel.fromDoc(snapshot);
  }

  Stream<int> adsCount() =>
      _banners.snapshots().map((snap) => snap.docs.length);
}
