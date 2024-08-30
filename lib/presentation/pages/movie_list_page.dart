import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/movie_list/movie_list_bloc.dart';
import '../blocs/movie_list/movie_list_event.dart';
import '../blocs/movie_list/movie_list_state.dart';
import '../widgets/movie_card.dart';
import 'movie_details_page.dart';

class MovieListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: BlocBuilder<MovieListBloc, MovieListState>(
        builder: (context, state) {
          if (state is MovieListLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MovieListLoaded) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,  // Number of columns
                crossAxisSpacing: 4.0,  // Spacing between columns
                mainAxisSpacing: 4.0,  // Spacing between rows
                childAspectRatio: 0.6,  // Aspect ratio for each item (width / height)
              ),
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailsPage(movie: movie),
                      ),
                    );
                  },
                  child: MovieCard(movie: movie),
                );
              },
            );
          } else {
            return Center(child: Text('Failed to load movies'));
          }
        },
      ),
    );
  }
}
