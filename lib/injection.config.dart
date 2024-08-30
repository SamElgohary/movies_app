// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:movies_app/core/register_module.dart' as _i715;
import 'package:movies_app/data/repositories/movie_repository.dart' as _i742;
import 'package:movies_app/data/services/api_service.dart' as _i414;
import 'package:movies_app/domain/usecases/get_movies.dart' as _i700;
import 'package:movies_app/domain/usecases/search_movie.dart' as _i243;
import 'package:movies_app/presentation/blocs/movie_list/movie_list_bloc.dart'
    as _i982;
import 'package:movies_app/presentation/blocs/movie_search/movie_search_bloc.dart'
    as _i13;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i414.ApiService>(
        () => registerModule.provideApiService(gh<_i361.Dio>()));
    gh.lazySingleton<_i742.MovieRepository>(
        () => registerModule.provideMovieRepository(gh<_i414.ApiService>()));
    gh.lazySingleton<_i243.SearchMovies>(
        () => registerModule.provideSearchMovies(gh<_i742.MovieRepository>()));
    gh.factory<_i13.MovieSearchBloc>(
        () => registerModule.provideMovieSearchBloc(gh<_i243.SearchMovies>()));
    gh.factory<_i700.GetMovies>(
        () => _i700.GetMovies(gh<_i742.MovieRepository>()));
    gh.factory<_i982.MovieListBloc>(
        () => _i982.MovieListBloc(gh<_i700.GetMovies>()));
    return this;
  }
}

class _$RegisterModule extends _i715.RegisterModule {}
