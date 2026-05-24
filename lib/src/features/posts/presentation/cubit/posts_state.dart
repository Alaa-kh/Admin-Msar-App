import 'package:admin_msar/src/features/posts/domain/entities/post.dart';

sealed class PostsState {
  const PostsState();
}

class PostsInitial extends PostsState {
  const PostsInitial();
}

class PostsLoading extends PostsState {
  const PostsLoading();
}

class PostsLoaded extends PostsState {
  const PostsLoaded(this.posts, {this.deletingId});
  final List<Post> posts;
  final String? deletingId;

  PostsLoaded copyWith({List<Post>? posts, String? deletingId}) =>
      PostsLoaded(posts ?? this.posts, deletingId: deletingId);
}

class PostsError extends PostsState {
  const PostsError(this.message);
  final String message;
}
