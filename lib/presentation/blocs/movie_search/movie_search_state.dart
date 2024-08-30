import 'package:equatable/equatable.dart';
import '../../../domain/entities/movie.dart';

abstract class MovieSearchState extends Equatable {
  const MovieSearchState();

  @override
  List<Object> get props => [];
}

class MovieSearchInitial extends MovieSearchState {}

class MovieSearchLoading extends MovieSearchState {}

class MovieSearchLoaded extends MovieSearchState {
  final List<Movie> movies;

  const MovieSearchLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

class MovieSearchError extends MovieSearchState {
  final String message;

  const MovieSearchError({required this.message});

  @override
  List<Object> get props => [message];
}
