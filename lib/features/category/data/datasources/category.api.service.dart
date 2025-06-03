import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:notes_application/core/constants/api.urls.dart';
import 'package:notes_application/core/network/dio.client.dart';
import 'package:notes_application/features/category/data/models/category.model.dart';
import 'package:notes_application/injection.container.dart';

abstract class CategoryApiService {
  Future<List<Category>> getAllCategories();
  Future<Category> getCategoryById(int id);
  Future<Either> createCategory(Category category);
  Future<Either> updateCategory(int id, Category category);
  Future<Either> deleteCategory(int id);
}

class CategoryApiServiceImpl extends CategoryApiService {
  
  @override
  Future<List<Category>> getAllCategories() async {
    try {
      final response = await sl<DioClient>().get(ApiUrls.categories);
      final data = response.data as List<dynamic>; 
      return data.map((e) => Category.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception('Error al obtener categorías: ${e.message}');
    }
  }

  @override
  Future<Category> getCategoryById(int id) async {
    try {
      final response = await sl<DioClient>().get('${ApiUrls.categories}/$id');
      return Category.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Error al obtener la categoría: ${e.message}');
    }
  }

  @override
  Future<Either> createCategory(Category category) async {
    try {
      var response = await sl<DioClient>().post(
        ApiUrls.categories, 
        data: category.toMap(),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response);
    }
  }

  @override
  Future<Either> updateCategory(int id, Category category) async {
    try {
      var response = await sl<DioClient>().put(
        '${ApiUrls.categories}/$id',
        data: category.toMap(),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response);
    }
  }

  @override
  Future<Either> deleteCategory(int id) async {
    try {
      var response = await sl<DioClient>().delete(
        '${ApiUrls.categories}/$id', 
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response);
    }
  }
}