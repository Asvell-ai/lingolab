import 'package:equatable/equatable.dart';
import 'package:lingolab_app/features/home/data/models/home_models.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final HomeResponse homeResponse;

  const HomeLoaded({required this.homeResponse});

  @override
  List<Object?> get props => [homeResponse];
}

class HomeFilterLoaded extends HomeState {
  final List<CourseModel> courses;

  const HomeFilterLoaded({required this.courses});

  @override
  List<Object?> get props => [courses];
}

class HomeDetailLoaded extends HomeState {
  final CourseModel course;

  const HomeDetailLoaded({required this.course});

  @override
  List<Object?> get props => [course];
}

class HomeFailure extends HomeState {
  final String message;

  const HomeFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
