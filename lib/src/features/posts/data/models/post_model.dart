import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:admin_msar/src/features/posts/domain/entities/post.dart';

class PostModel {
  const PostModel({
    required this.id,
    required this.title,
    required this.description,
    required this.whatsapp,
    required this.audience,
    required this.isActive,
    required this.company,
    required this.city,
    this.createdAt,
  });

  final String id;
  final String title;
  final String description;
  final String whatsapp;
  final String audience;
  final bool isActive;
  final String company;
  final String city;
  final DateTime? createdAt;

  factory PostModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? const {};
    return PostModel(
      id: doc.id,
      title: (data['title'] ?? '') as String,
      description: (data['description'] ?? '') as String,
      whatsapp: (data['whatsapp'] ?? '') as String,
      audience: (data['audience'] ?? 'all') as String,
      isActive: (data['isActive'] ?? true) as bool,
      company: (data['company'] ?? '') as String,
      city: (data['city'] ?? '') as String,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  Post toEntity() => Post(
    id: id,
    title: title,
    description: description,
    whatsapp: whatsapp,
    audience: postAudienceFromString(audience),
    isActive: isActive,
    company: company,
    city: city,
    createdAt: createdAt,
  );
}
