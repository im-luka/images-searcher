import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photos_api/models/models.dart';
import 'package:url_launcher/url_launcher.dart';

class PhotoViewer extends StatefulWidget {
  const PhotoViewer({
    Key? key,
    required this.photos,
    required this.currentIndex,
  }) : super(key: key);

  final List<Photo> photos;
  final int currentIndex;

  @override
  _PhotoViewerState createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.photos.length,
        itemBuilder: (context, index) {
          final photo = widget.photos[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: Key('${index}_${photo.id}'),
                child: CachedNetworkImage(
                  height: 300.0,
                  width: double.infinity,
                  imageUrl: photo.url,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 50.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${index + 1}/${widget.photos.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      photo.description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 27.0,
                          backgroundColor: Colors.grey[100],
                          backgroundImage: CachedNetworkImageProvider(
                            photo.user.profileImageUrl,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 13.0),
                          child: GestureDetector(
                            onTap: () async {
                              final url = photo.user.profileUrl;
                              if (await canLaunch(url)) {
                                await launch(url);
                              }
                            },
                            child: Text(
                              photo.user.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
