import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter/model/postsModel.dart';
import 'package:riverpod_flutter/services/http_services.dart';

final postsProvider =
    StateNotifierProvider<PostNotifier, PostState>((ref) => PostNotifier());

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;
  PostLoaded({required this.posts});
}

class PostError extends PostState {
  final String message;
  PostError({required this.message});
}

class PostNotifier extends StateNotifier<PostState> {
  PostNotifier() : super(PostInitial());
  final HttpGetServices httpGetServices = HttpGetServices();

  void fetchPosts() async {
    try {
      state = PostLoading();
      List<Post> posts = await httpGetServices.getPosts();
      state = PostLoaded(posts: posts);
    } catch (e) {
      state = PostError(message: e.toString());
    }
  }
}
