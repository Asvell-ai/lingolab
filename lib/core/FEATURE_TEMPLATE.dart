/// NEW FEATURE TEMPLATE
///
/// Bu template yangi feature yaratish uchun
/// Quyidagi fayllari copy-paste qilib, feature nomiga o'zgarting
///
/// STRUKTURA:
/// features/feature_name/
/// ├── data/
/// │   ├── models/
/// │   │   └── feature_models.dart
/// │   ├── datasources/
/// │   │   └── feature_remote_datasource.dart
/// │   └── repositories/
/// │       └── feature_repository.dart
/// └── presentation/
///     ├── cubit/
///     │   ├── feature_cubit.dart
///     │   └── feature_state.dart
///     ├── pages/
///     │   └── feature_page.dart
///     └── widgets/
///         └── custom_widgets.dart
///
/// STEPS:
/// 1. Yuqoridagi struktura yaratish
/// 2. Models qo'shish (fromJson, toJson, copyWith)
/// 3. Datasource abstract va impl
/// 4. Repository abstract va impl
/// 5. Cubit va State
/// 6. Pages va Widgets
/// 7. injection_container.dart-ga register qilish
///
/// EXAMPLE FEATURE NAME: products
///
/// ============== 1. MODELS ==============
///
/// // lib/features/products/data/models/product_models.dart
///
/// import 'package:equatable/equatable.dart';
///
/// class ProductModel extends Equatable {
///   final String id;
///   final String name;
///   final double price;
///   final String description;
///
///   const ProductModel({
///     required this.id,
///     required this.name,
///     required this.price,
///     required this.description,
///   });
///
///   factory ProductModel.fromJson(Map<String, dynamic> json) {
///     return ProductModel(
///       id: json['id'] ?? '',
///       name: json['name'] ?? '',
///       price: (json['price'] ?? 0.0).toDouble(),
///       description: json['description'] ?? '',
///     );
///   }
///
///   Map<String, dynamic> toJson() {
///     return {
///       'id': id,
///       'name': name,
///       'price': price,
///       'description': description,
///     };
///   }
///
///   ProductModel copyWith({
///     String? id,
///     String? name,
///     double? price,
///     String? description,
///   }) {
///     return ProductModel(
///       id: id ?? this.id,
///       name: name ?? this.name,
///       price: price ?? this.price,
///       description: description ?? this.description,
///     );
///   }
///
///   @override
///   List<Object?> get props => [id, name, price, description];
/// }
///
/// ============== 2. DATASOURCE ==============
///
/// // lib/features/products/data/datasources/product_remote_datasource.dart
///
/// import 'package:dio/dio.dart';
/// import 'package:lingolab_app/core/network/app_dio.dart';
/// import 'package:lingolab_app/features/products/data/models/product_models.dart';
///
/// abstract class ProductRemoteDatasource {
///   Future<List<ProductModel>> getProducts();
/// }
///
/// class ProductRemoteDatasourceImpl implements ProductRemoteDatasource {
///   final AppDio appDio;
///
///   ProductRemoteDatasourceImpl({required this.appDio});
///
///   @override
///   Future<List<ProductModel>> getProducts() async {
///     try {
///       final response = await appDio.get('/products');
///
///       if (response.statusCode == 200) {
///         final data = response.data;
///         if (data is List) {
///           return List<ProductModel>.from(
///             data.map((p) => ProductModel.fromJson(p)),
///           );
///         }
///         throw Exception('Invalid response');
///       }
///       throw Exception('Failed to fetch products');
///     } on DioException catch (e) {
///       throw Exception('Network error');
///     }
///   }
/// }
///
/// ============== 3. REPOSITORY ==============
///
/// // lib/features/products/data/repositories/product_repository.dart
///
/// import 'package:lingolab_app/features/products/data/datasources/product_remote_datasource.dart';
/// import 'package:lingolab_app/features/products/data/models/product_models.dart';
///
/// abstract class ProductRepository {
///   Future<List<ProductModel>> getProducts();
/// }
///
/// class ProductRepositoryImpl implements ProductRepository {
///   final ProductRemoteDatasource remoteDatasource;
///
///   ProductRepositoryImpl({required this.remoteDatasource});
///
///   @override
///   Future<List<ProductModel>> getProducts() async {
///     try {
///       return await remoteDatasource.getProducts();
///     } catch (e) {
///       rethrow;
///     }
///   }
/// }
///
/// ============== 4. STATE ==============
///
/// // lib/features/products/presentation/cubit/product_state.dart
///
/// import 'package:equatable/equatable.dart';
/// import 'package:lingolab_app/features/products/data/models/product_models.dart';
///
/// abstract class ProductState extends Equatable {
///   const ProductState();
///
///   @override
///   List<Object?> get props => [];
/// }
///
/// class ProductInitial extends ProductState {
///   const ProductInitial();
/// }
///
/// class ProductLoading extends ProductState {
///   const ProductLoading();
/// }
///
/// class ProductLoaded extends ProductState {
///   final List<ProductModel> products;
///
///   const ProductLoaded({required this.products});
///
///   @override
///   List<Object?> get props => [products];
/// }
///
/// class ProductFailure extends ProductState {
///   final String message;
///
///   const ProductFailure({required this.message});
///
///   @override
///   List<Object?> get props => [message];
/// }
///
/// ============== 5. CUBIT ==============
///
/// // lib/features/products/presentation/cubit/product_cubit.dart
///
/// import 'package:flutter_bloc/flutter_bloc.dart';
/// import 'package:lingolab_app/features/products/data/repositories/product_repository.dart';
/// import 'package:lingolab_app/features/products/presentation/cubit/product_state.dart';
///
/// class ProductCubit extends Cubit<ProductState> {
///   final ProductRepository repository;
///
///   ProductCubit({required this.repository}) : super(const ProductInitial());
///
///   Future<void> fetchProducts() async {
///     emit(const ProductLoading());
///     try {
///       final products = await repository.getProducts();
///       emit(ProductLoaded(products: products));
///     } catch (e) {
///       emit(ProductFailure(message: e.toString()));
///     }
///   }
/// }
///
/// ============== 6. PAGE ==============
///
/// // lib/features/products/presentation/pages/products_page.dart
///
/// import 'package:flutter/material.dart';
/// import 'package:flutter_bloc/flutter_bloc.dart';
/// import 'package:lingolab_app/features/products/presentation/cubit/product_cubit.dart';
/// import 'package:lingolab_app/features/products/presentation/cubit/product_state.dart';
///
/// class ProductsPage extends StatefulWidget {
///   const ProductsPage({super.key});
///
///   @override
///   State<ProductsPage> createState() => _ProductsPageState();
/// }
///
/// class _ProductsPageState extends State<ProductsPage> {
///   @override
///   void initState() {
///     super.initState();
///     context.read<ProductCubit>().fetchProducts();
///   }
///
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       appBar: AppBar(title: const Text('Products')),
///       body: BlocBuilder<ProductCubit, ProductState>(
///         builder: (context, state) {
///           if (state is ProductLoading) {
///             return const Center(child: CircularProgressIndicator());
///           }
///
///           if (state is ProductLoaded) {
///             return ListView.builder(
///               itemCount: state.products.length,
///               itemBuilder: (context, index) {
///                 final product = state.products[index];
///                 return ListTile(
///                   title: Text(product.name),
///                   subtitle: Text('\$${product.price}'),
///                 );
///               },
///             );
///           }
///
///           if (state is ProductFailure) {
///             return Center(
///               child: Text(state.message),
///             );
///           }
///
///           return const Center(child: Text('No data'));
///         },
///       ),
///     );
///   }
/// }
///
/// ============== 7. DEPENDENCY INJECTION ==============
///
/// // injection_container.dart-ga add qiling
///
/// // Products
/// getIt.registerSingleton<ProductRemoteDatasource>(
///   ProductRemoteDatasourceImpl(appDio: getIt<AppDio>()),
/// );
///
/// getIt.registerSingleton<ProductRepository>(
///   ProductRepositoryImpl(remoteDatasource: getIt<ProductRemoteDatasource>()),
/// );
///
/// getIt.registerSingleton<ProductCubit>(
///   ProductCubit(repository: getIt<ProductRepository>()),
/// );
///
/// ============== 8. MAIN.DART-GA ADD ==============
///
/// BlocProvider(
///   create: (context) => getIt<ProductCubit>(),
/// ),
///
/// routes: {
///   '/products': (context) => const ProductsPage(),
/// },

// Ushbu file shunchaki dokumentasyon. Faylning o'zi foydasiz.
