import 'package:injectable/injectable.dart';

import '../../data/models/movie_model.dart';
import '../../data/repositories/movie_repository.dart';

@injectable
class GetMovies {
  final MovieRepository repository;

  GetMovies(this.repository);

  Future<List<MovieModel>> call() async {
    return await repository.getMovies();
  }
}
