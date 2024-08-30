import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/movie_model.dart';
import 'movie_search_event.dart';
import 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final Future<List<MovieModel>> Function(String) searchMovies;

  MovieSearchBloc({required this.searchMovies}) : super(MovieSearchInitial()) {
    on<SearchMovies>(_onSearchMovies);
  }

  Future<void> _onSearchMovies(SearchMovies event, Emitter<MovieSearchState> emit) async {
    emit(MovieSearchLoading());
    try {
      final movies = await searchMovies(event.query);
      emit(MovieSearchLoaded(movies: movies));
    } catch (e) {
      emit(MovieSearchError(message: e.toString()));
    }
  }
}
