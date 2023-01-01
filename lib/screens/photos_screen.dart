import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:photos_api/models/models.dart';
import 'package:photos_api/repositories/repositories.dart';
import 'package:photos_api/widgets/widgets.dart';

class PhotosScreen extends StatefulWidget {
  const PhotosScreen({Key? key}) : super(key: key);

  @override
  _PhotosScreenState createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  String _query = 'programming';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Photos'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search...',
                fillColor: Colors.white,
                filled: true,
              ),
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  setState(() {
                    _query = value.trim();
                  });
                }
              },
            ),
            Expanded(
              child: FutureBuilder(
                future: PhotosRepository(httpClient: Client()).searchPhotos(
                  query: _query, /*page: Random().nextInt(10) + 1*/
                ),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final List<Photo> photos = snapshot.data;
                    return GridView.builder(
                      padding: const EdgeInsets.all(15.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 15.0,
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: photos.length,
                      itemBuilder: (context, index) {
                        final photo = photos[index];
                        return PhotoCard(
                          photo: photo,
                          currentIndex: index,
                          photos: photos,
                        );
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
