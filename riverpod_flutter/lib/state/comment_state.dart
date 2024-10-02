import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter/model/commentModel.dart';
import 'package:riverpod_flutter/services/http_services.dart';

final commentProvider =
    StateNotifierProvider<CommentNotifierStatesHunBhai, CommentState>(
        (ref) => CommentNotifierStatesHunBhai());

@immutable
abstract class CommentState {}

class CommentStateInitial extends CommentState {}

class CommentStateLoading extends CommentState {}

class CommentStateLoaded extends CommentState {
  final List<CommentModel> commentmodel;

  CommentStateLoaded({required this.commentmodel});
}

class CommentStateError extends CommentState {
  final String error;
  CommentStateError({required this.error});
}

class CommentNotifierStatesHunBhai extends StateNotifier<CommentState> {
  CommentNotifierStatesHunBhai() : super(CommentStateInitial());
  void fetchComment() async {
    try {
      HttpGetServices _httpGetServices = HttpGetServices();
      state = CommentStateLoading();
      List<CommentModel> commentModel = await _httpGetServices.getComments();
      state = CommentStateLoaded(commentmodel: commentModel);
    } catch (e) {
      state = CommentStateError(error: e.toString());
    }
  }
}
