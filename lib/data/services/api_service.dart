import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/movie_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://api.themoviedb.org/3/")
abstract class ApiService {
  @factoryMethod
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/movie/popular")
  Future<MovieResponse> getPopularMovies(@Query("api_key") String apiKey);

  // New method to search for movies
  @GET("/search/movie")
  Future<MovieResponse> searchMovies(
      @Query("api_key") String apiKey,
      @Query("query") String query,
      );
}

@JsonSerializable()
class MovieResponse {
  final List<MovieModel> results;

  MovieResponse({required this.results});

  factory MovieResponse.fromJson(Map<String, dynamic> json) => _$MovieResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MovieResponseToJson(this);
}
