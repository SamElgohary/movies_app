import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_movies.dart';
import 'movie_list_event.dart';
import 'movie_list_state.dart';

@injectable
class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetMovies getMovies;

  MovieListBloc(this.getMovies) : super(MovieListInitial()) {
    on<FetchMovies>((event, emit) async {
      emit(MovieListLoading());
      try {
        final movies = await getMovies();
        emit(MovieListLoaded(movies));
      } catch (_) {
        emit(MovieListError());
      }
    });
  }
}
