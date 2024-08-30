import '../../data/models/movie_model.dart';
import '../../data/repositories/movie_repository.dart';

class SearchMovies {
  final MovieRepository repository;

  SearchMovies(this.repository);

  Future<List<MovieModel>> call(String query) async {
    return repository.searchMovies(query);
  }
}
