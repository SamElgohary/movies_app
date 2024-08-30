import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../domain/entities/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),  // Adjust the radius as needed
                topRight: Radius.circular(10.0), // Adjust the radius as needed
              ),
              child: CachedNetworkImage(
                imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                fit: BoxFit.cover,  // Ensures the image covers the space
                placeholder: (context, url) => Center(child: CircularProgressIndicator()),  // Placeholder while loading
                errorWidget: (context, url, error) => Icon(Icons.error),  // Error widget if image fails to load
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movie.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
              maxLines: 1,  // Limiting to 1 line to avoid overflow
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
