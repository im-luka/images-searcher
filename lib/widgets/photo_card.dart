import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photos_api/models/models.dart';
import 'package:photos_api/screens/screens.dart';

class PhotoCard extends StatelessWidget {
  const PhotoCard({
    Key? key,
    required this.photo,
    required this.photos,
    required this.currentIndex,
  }) : super(key: key);

  final List<Photo> photos;
  final int currentIndex;
  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PhotoViewer(
              currentIndex: currentIndex,
              photos: photos,
            ),
          ),
        );
      },
      child: Hero(
        tag: Key('${currentIndex}_${photo.id}'),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
                blurRadius: 4.0,
              ),
            ],
            image: DecorationImage(
              image: CachedNetworkImageProvider(photo.url),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
