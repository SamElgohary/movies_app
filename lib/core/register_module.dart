import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:movies_app/data/services/api_service.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio();

  @lazySingleton
  ApiService provideApiService(Dio dio) => ApiService(dio);  // Registers the generated _ApiService
}
