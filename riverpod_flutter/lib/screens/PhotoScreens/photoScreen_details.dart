import 'package:flutter/material.dart';
import 'package:riverpod_flutter/model/photoModel.dart';

class PhotoDetailsScreen extends StatelessWidget {
  const PhotoDetailsScreen({super.key, required this.model});
  final PhotoModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Photo Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(model.title),
            SizedBox(
                width: double.infinity,
                height: 200,
                child: Image.network(fit: BoxFit.cover, model.thumbnailUrl)),
          ],
        ),
      ),
    );
  }
}
