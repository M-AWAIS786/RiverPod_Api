import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter/state/comment_state.dart';

class CommentScreens extends ConsumerWidget {
  const CommentScreens({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comment Screen'),
      ),
      body: Consumer(
        builder: (
          context,
          ref,
          child,
        ) {
          CommentState state = ref.watch(commentProvider);
          if (state is CommentStateInitial) {
            return Text('Press button to fetch Data');
          }
          if (state is CommentStateLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is CommentStateError) {
            return Center(child: Text(state.error));
          }
          if (state is CommentStateLoaded) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.commentmodel.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(state.commentmodel[index].id.toString()),
                    ),
                    title: Text(state.commentmodel[index].name),
                    subtitle: Text(state.commentmodel[index].body),
                  ),
                );
              },
            );
          }
          return Text('');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(commentProvider.notifier).fetchComment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
