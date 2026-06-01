import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingolab_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:lingolab_app/features/home/presentation/cubit/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Courses')),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HomeLoaded) {
            final courses = state.homeResponse.courses;
            final categories = state.homeResponse.categories;

            return Column(
              children: [
                if (categories.isNotEmpty)
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(categories[index]),
                            onSelected: (selected) {
                              if (selected) {
                                context
                                    .read<HomeCubit>()
                                    .filterByCategory(categories[index]);
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                Expanded(
                  child: ListView.builder(
                    itemCount: courses.length,
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      final course = courses[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: ListTile(
                          leading: course.image != null
                              ? Image.network(
                                  course.image!,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  width: 60,
                                  height: 60,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.book),
                                ),
                          title: Text(course.title),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(course.category),
                              Row(
                                children: [
                                  const Icon(Icons.star,
                                      size: 16, color: Colors.amber),
                                  Text(' ${course.rating}'),
                                  const SizedBox(width: 8),
                                  Text('${course.lessonCount} lessons'),
                                ],
                              ),
                            ],
                          ),
                          trailing: const Icon(Icons.arrow_forward),
                          onTap: () {
                            context
                                .read<HomeCubit>()
                                .fetchCourseDetail(course.id);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }

          if (state is HomeFilterLoaded) {
            final courses = state.courses;
            return ListView.builder(
              itemCount: courses.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final course = courses[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    title: Text(course.title),
                    subtitle: Text(course.category),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      context
                          .read<HomeCubit>()
                          .fetchCourseDetail(course.id);
                    },
                  ),
                );
              },
            );
          }

          if (state is HomeFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<HomeCubit>().fetchCourses();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return const Center(child: Text('No data'));
        },
      ),
    );
  }
}
