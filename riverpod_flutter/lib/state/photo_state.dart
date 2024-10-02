import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter/model/photoModel.dart';
import 'package:riverpod_flutter/services/http_services.dart';

final PhotoProvider =
    StateNotifierProvider<PhotoNotifier, PhotoState>((ref) => PhotoNotifier());

@immutable
abstract class PhotoState {}

class PhotoStateInitial extends PhotoState {}

class PhotoStateLoading extends PhotoState {}

class PhotoStateError extends PhotoState {
  final String message;
  PhotoStateError({required this.message});
}

class PhotoStateLoaded extends PhotoState {
  final List<PhotoModel> photos;

  PhotoStateLoaded({required this.photos});
}

class PhotoNotifier extends StateNotifier<PhotoState> {
  PhotoNotifier() : super(PhotoStateInitial());
  void fetchPhotos() async {
    try {
      HttpGetServices httpGetServices = HttpGetServices();
      state = PhotoStateLoading();
      List<PhotoModel> photosData = await httpGetServices.getPhotos();
      state = PhotoStateLoaded(photos: photosData);
    } catch (e) {
      state = PhotoStateError(message: e.toString());
    }
  }
}
