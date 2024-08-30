import '../models/movie_model.dart';
import '../services/api_service.dart';

class MovieRepository {
  final ApiService apiService;

  MovieRepository(this.apiService);

  Future<List<MovieModel>> getMovies() async {
    final response = await apiService.getPopularMovies("04d823729c15d7456792cff9eb04ba59");
    return response.results;
  }
}
