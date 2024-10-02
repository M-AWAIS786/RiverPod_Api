import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter/state/post_state.dart';

class PostScreen extends ConsumerWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: Consumer(builder: (context, ref, child) {
          PostState state = ref.watch(postsProvider);
          if (state is PostInitial) {
            return Text('Press button to fetch Data');
          }
          if (state is PostLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PostError) {
            return Text(state.message);
          }
          if (state is PostLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(state.posts[index].id.toString()),
                    ),
                    title: Text(state.posts[index].title),
                    subtitle: Text(state.posts[index].body),
                  ),
                );
              },
            );
          }
          return Text('Nothing');
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ref.read(postsProvider.notifier).fetchPosts();
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
