import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter/model/photoModel.dart';
import 'package:riverpod_flutter/screens/PhotoScreens/photoScreen_details.dart';
import 'package:riverpod_flutter/state/photo_state.dart';

class PhotoScreen extends ConsumerWidget {
  const PhotoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          PhotoState state = ref.watch(PhotoProvider);
          if (state is PhotoStateInitial) {
            return const Center(
              child: Text(
                'Press button to fetch Data',
              ),
            );
          }
          if (state is PhotoStateLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PhotoStateError) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is PhotoStateLoaded) {
            return ListView.builder(
              itemCount: state.photos.length,
              itemBuilder: (context, index) {
                PhotoModel photoModel = state.photos[index];
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PhotoDetailsScreen(
                          model: photoModel,
                        ),
                      ));
                    },
                    leading: CircleAvatar(
                      child: Text(
                        state.photos[index].id.toString(),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    title: Text(state.photos[index].title),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(PhotoProvider.notifier).fetchPhotos();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
