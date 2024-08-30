import 'package:flutter_bloc/flutter_bloc.dart';
import 'movie_details_event.dart';
import 'movie_details_state.dart';
import '../../../domain/entities/movie.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  MovieDetailsBloc() : super(MovieDetailsInitial()) {
    on<SelectMovie>((event, emit) {
      emit(MovieDetailsLoaded(event.movie));
    });
  }
}
