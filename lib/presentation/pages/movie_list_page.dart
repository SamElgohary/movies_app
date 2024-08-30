import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/movie.dart';
import '../blocs/movie_list/movie_list_bloc.dart';
import '../blocs/movie_list/movie_list_state.dart';
import '../blocs/movie_search/movie_search_bloc.dart';
import '../blocs/movie_search/movie_search_event.dart';
import '../blocs/movie_search/movie_search_state.dart';
import '../widgets/movie_card.dart';
import 'movie_details_page.dart';

class MovieListPage extends StatefulWidget {
  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            hintText: 'Search Movies...',
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                if (_searchController.text.isNotEmpty) {
                  setState(() {
                    _isSearching = true;
                  });
                  context.read<MovieSearchBloc>().add(SearchMovies(_searchController.text));

                }
              },
            ),
          ),
          onChanged: (query) {
            if (query.isNotEmpty) {
              setState(() {
                _isSearching = true;
              });
              context.read<MovieSearchBloc>().add(SearchMovies(_searchController.text));
            }
          },
        ),
      ),
      body: _isSearching
          ? BlocBuilder<MovieSearchBloc, MovieSearchState>(
        builder: (context, state) {
          if (state is MovieSearchLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MovieSearchLoaded) {
            return _buildMovieList(state.movies);
          } else if (state is MovieSearchError) {
            return Center(child: Text('Failed to load movies'));
          }
          return Center(child: Text('Start searching for movies'));
        },
      )
          : BlocBuilder<MovieListBloc, MovieListState>(
        builder: (context, state) {
          if (state is MovieListLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MovieListLoaded) {
            return _buildMovieList(state.movies);
          } else if (state is MovieListError) {
            return Center(child: Text('Failed to load movies'));
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildMovieList(List<Movie> movies) {

    if (movies.isEmpty) {
      return Center(
        child: Text(
          'No movies found',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return Center(
      child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,  // Number of columns
      crossAxisSpacing: 4.0,  // Spacing between columns
      mainAxisSpacing: 4.0,  // Spacing between rows
      childAspectRatio: 0.6,  // Aspect ratio for each item (width / height)
    ),
    itemCount: movies.length,
    itemBuilder: (context, index) {
    final movie = movies[index];
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
    ),
    );
  }
}
