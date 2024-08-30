import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../domain/entities/movie.dart';

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;

  MovieDetailsPage({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: ListView(
        children: [
          CachedNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
            fit: BoxFit.fitWidth,  // Ensures the image covers the space
            placeholder: (context, url) => Center(child: CircularProgressIndicator()),  // Placeholder while loading
            errorWidget: (context, url, error) => Icon(Icons.error),  // Error widget if image fails to load
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(movie.overview),
          ),
        ],
      ),
    );
  }
}
