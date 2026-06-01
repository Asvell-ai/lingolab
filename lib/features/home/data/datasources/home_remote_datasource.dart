import 'package:dio/dio.dart';
import 'package:lingolab_app/core/constants/app_constants.dart';
import 'package:lingolab_app/core/network/app_dio.dart';
import 'package:lingolab_app/features/home/data/models/home_models.dart';

abstract class HomeRemoteDatasource {
  Future<HomeResponse> getCourses();
  Future<List<CourseModel>> getCoursesByCategory(String category);
  Future<CourseModel> getCourseDetail(String id);
}

class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  final AppDio appDio;

  HomeRemoteDatasourceImpl({required this.appDio});

  @override
  Future<HomeResponse> getCourses() async {
    try {
      final response = await appDio.get(
        '${AppConstants.apiVersion}/courses',
      );

      if (response.statusCode == 200) {
        return HomeResponse.fromJson(response.data);
      }
      throw Exception('Failed to fetch courses');
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<List<CourseModel>> getCoursesByCategory(String category) async {
    try {
      final response = await appDio.get(
        '${AppConstants.apiVersion}/courses',
        queryParameters: {'category': category},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data is List) {
          return List<CourseModel>.from(
            data.map((course) => CourseModel.fromJson(course)),
          );
        }
        throw Exception('Invalid response format');
      }
      throw Exception('Failed to fetch courses');
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<CourseModel> getCourseDetail(String id) async {
    try {
      final response = await appDio.get(
        '${AppConstants.apiVersion}/courses/$id',
      );

      if (response.statusCode == 200) {
        return CourseModel.fromJson(response.data);
      }
      throw Exception('Failed to fetch course detail');
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  Exception _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return Exception('Connection timeout');
      case DioExceptionType.badResponse:
        return Exception('Server error: ${e.response?.statusCode}');
      case DioExceptionType.cancel:
        return Exception('Request cancelled');
      default:
        return Exception('Network error');
    }
  }
}
