import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingolab_app/features/home/data/repositories/home_repository.dart';
import 'package:lingolab_app/features/home/presentation/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repository;

  HomeCubit({required this.repository}) : super(const HomeInitial());

  Future<void> fetchCourses() async {
    emit(const HomeLoading());
    try {
      final response = await repository.getCourses();
      emit(HomeLoaded(homeResponse: response));
    } catch (e) {
      emit(HomeFailure(message: e.toString()));
    }
  }

  Future<void> filterByCategory(String category) async {
    emit(const HomeLoading());
    try {
      final courses = await repository.getCoursesByCategory(category);
      emit(HomeFilterLoaded(courses: courses));
    } catch (e) {
      emit(HomeFailure(message: e.toString()));
    }
  }

  Future<void> fetchCourseDetail(String id) async {
    emit(const HomeLoading());
    try {
      final course = await repository.getCourseDetail(id);
      emit(HomeDetailLoaded(course: course));
    } catch (e) {
      emit(HomeFailure(message: e.toString()));
    }
  }
}
