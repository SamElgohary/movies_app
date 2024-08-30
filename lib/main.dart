import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/presentation/blocs/movie_list/movie_list_event.dart';
import 'injection.dart';
import 'presentation/pages/movie_list_page.dart';
import 'presentation/blocs/movie_list/movie_list_bloc.dart';

void main() {
  configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => getIt<MovieListBloc>()..add(FetchMovies()),
        child: MovieListPage(),
      ),
    );
  }
}
