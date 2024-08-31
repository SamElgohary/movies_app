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

  void _onSearchSubmitted(String query) {
    if (query.isNotEmpty) {
      setState(() {
        _isSearching = true;
      });
      context.read<MovieSearchBloc>().add(SearchMovies(query));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _isSearching ? _buildSearchResults() : _buildMovieList(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search Movies...',
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () => _onSearchSubmitted(_searchController.text),
          ),
        ),
        onChanged: _onSearchSubmitted,
      ),
    );
  }

  Widget _buildSearchResults() {
    return BlocBuilder<MovieSearchBloc, MovieSearchState>(
      builder: (context, state) {
        if (state is MovieSearchLoading) {
          return _buildLoadingIndicator();
        } else if (state is MovieSearchLoaded) {
          return _buildMovieGrid(state.movies);
        } else if (state is MovieSearchError) {
          return _buildErrorText('Failed to load movies');
        }
        return _buildPlaceholderText('Start searching for movies');
      },
    );
  }

  Widget _buildMovieList() {
    return BlocBuilder<MovieListBloc, MovieListState>(
      builder: (context, state) {
        if (state is MovieListLoading) {
          return _buildLoadingIndicator();
        } else if (state is MovieListLoaded) {
          return _buildMovieGrid(state.movies);
        } else if (state is MovieListError) {
          return _buildErrorText('Failed to load movies');
        }
        return Container();
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildErrorText(String message) {
    return Center(child: Text(message));
  }

  Widget _buildPlaceholderText(String message) {
    return Center(child: Text(message));
  }

  Widget _buildMovieGrid(List<Movie> movies) {
    if (movies.isEmpty) {
      return _buildPlaceholderText('No movies found');
    }
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = screenWidth > 600 ? 4 : 2; // 4 for tablets, 2 for mobile


    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
        childAspectRatio: 0.6,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return GestureDetector(
          onTap: () => _navigateToMovieDetails(movie),
          child: MovieCard(movie: movie),
        );
      },
    );
  }

  void _navigateToMovieDetails(Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MovieDetailsPage(movie: movie)),
    );
  }
}
