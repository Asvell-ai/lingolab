import 'package:equatable/equatable.dart';

class CourseModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String category;
  final int lessonCount;
  final String? image;
  final double rating;

  const CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.lessonCount,
    this.image,
    required this.rating,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      lessonCount: json['lessonCount'] ?? 0,
      image: json['image'],
      rating: (json['rating'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'lessonCount': lessonCount,
      'image': image,
      'rating': rating,
    };
  }

  CourseModel copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    int? lessonCount,
    String? image,
    double? rating,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      lessonCount: lessonCount ?? this.lessonCount,
      image: image ?? this.image,
      rating: rating ?? this.rating,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        category,
        lessonCount,
        image,
        rating,
      ];
}

class HomeResponse extends Equatable {
  final List<CourseModel> courses;
  final List<String> categories;

  const HomeResponse({
    required this.courses,
    required this.categories,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(
      courses: List<CourseModel>.from(
        (json['courses'] as List<dynamic>?)?.map(
              (course) => CourseModel.fromJson(course),
            ) ??
            [],
      ),
      categories: List<String>.from(
        (json['categories'] as List<dynamic>?) ?? [],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'courses': courses.map((course) => course.toJson()).toList(),
      'categories': categories,
    };
  }

  @override
  List<Object?> get props => [courses, categories];
}
