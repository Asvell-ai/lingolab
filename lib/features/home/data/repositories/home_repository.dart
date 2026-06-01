import 'package:lingolab_app/features/home/data/datasources/home_remote_datasource.dart';
import 'package:lingolab_app/features/home/data/models/home_models.dart';

abstract class HomeRepository {
  Future<HomeResponse> getCourses();
  Future<List<CourseModel>> getCoursesByCategory(String category);
  Future<CourseModel> getCourseDetail(String id);
}

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasource remoteDatasource;

  HomeRepositoryImpl({required this.remoteDatasource});

  @override
  Future<HomeResponse> getCourses() async {
    try {
      return await remoteDatasource.getCourses();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CourseModel>> getCoursesByCategory(String category) async {
    try {
      return await remoteDatasource.getCoursesByCategory(category);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CourseModel> getCourseDetail(String id) async {
    try {
      return await remoteDatasource.getCourseDetail(id);
    } catch (e) {
      rethrow;
    }
  }
}
