import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../data/repositories/movie_repository.dart';
import '../data/services/api_service.dart';
import '../domain/usecases/search_movie.dart';
import '../presentation/blocs/movie_search/movie_search_bloc.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio();

  @lazySingleton
  ApiService provideApiService(Dio dio) => ApiService(dio);

  @lazySingleton
  MovieRepository provideMovieRepository(ApiService apiService) => MovieRepository(apiService);

  @lazySingleton
  SearchMovies provideSearchMovies(MovieRepository movieRepository) => SearchMovies(movieRepository);

  @factoryMethod
  MovieSearchBloc provideMovieSearchBloc(SearchMovies searchMovies) => MovieSearchBloc(searchMovies: searchMovies.call);
}
