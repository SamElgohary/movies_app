import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/movie.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel extends Movie {
  @JsonKey(name: 'poster_path', defaultValue: '')  // Provide a default value if null
  final String posterPath;

  @JsonKey(defaultValue: '')  // Provide a default value if null
  final String overview;

  @JsonKey(defaultValue: '')  // Provide a default value if null
  final String title;

  MovieModel({
    required int id,
    required this.title,
    required this.overview,
    required this.posterPath,
  }) : super(id: id, title: title, overview: overview, posterPath: posterPath);

  factory MovieModel.fromJson(Map<String, dynamic> json) => _$MovieModelFromJson(json);
  Map<String, dynamic> toJson() => _$MovieModelToJson(this);
}
