import 'package:admin_msar/src/core/network/api_result.dart';
import 'package:admin_msar/src/features/posts/domain/entities/post.dart';

class CreatePostParams {
  const CreatePostParams({
    required this.title,
    required this.description,
    required this.whatsapp,
    required this.audience,
    this.company = '',
    this.city = '',
  });

  final String title;
  final String description;
  final String whatsapp;
  final PostAudience audience;
  final String company;
  final String city;
}

abstract interface class PostsRepository {
  Future<ApiResult<List<Post>>> getPosts();

  Future<ApiResult<void>> deletePost(String id);

  Future<ApiResult<Post>> createPost(CreatePostParams params);

  Stream<int> postsCount();
}
