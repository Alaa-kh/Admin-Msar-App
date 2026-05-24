import 'package:admin_msar/src/features/posts/domain/entities/post.dart';

sealed class AddPostState {
  const AddPostState();
}

class AddPostInitial extends AddPostState {
  const AddPostInitial();
}

class AddPostSubmitting extends AddPostState {
  const AddPostSubmitting();
}

class AddPostSuccess extends AddPostState {
  const AddPostSuccess(this.post);
  final Post post;
}

class AddPostError extends AddPostState {
  const AddPostError(this.message);
  final String message;
}
