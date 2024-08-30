import '../../../domain/entities/movie.dart';

abstract class MovieDetailsEvent {}

class SelectMovie extends MovieDetailsEvent {
  final Movie movie;

  SelectMovie(this.movie);
}
