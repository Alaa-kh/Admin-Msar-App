enum PostAudience { all, men, women }

PostAudience postAudienceFromString(String value) {
  return switch (value) {
    'men' => PostAudience.men,
    'women' => PostAudience.women,
    _ => PostAudience.all,
  };
}

String postAudienceToString(PostAudience audience) {
  return switch (audience) {
    PostAudience.men => 'men',
    PostAudience.women => 'women',
    PostAudience.all => 'all',
  };
}

String postAudienceLabel(PostAudience audience) {
  return switch (audience) {
    PostAudience.men => 'ذكور',
    PostAudience.women => 'إناث',
    PostAudience.all => 'الكل',
  };
}

class Post {
  const Post({
    required this.id,
    required this.title,
    required this.description,
    required this.whatsapp,
    required this.audience,
    required this.isActive,
    this.company = '',
    this.city = '',
    this.createdAt,
  });

  final String id;
  final String title;
  final String description;
  final String whatsapp;
  final PostAudience audience;
  final bool isActive;
  final String company;
  final String city;
  final DateTime? createdAt;
}
