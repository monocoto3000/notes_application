import 'package:dartz/dartz.dart';
import 'package:notes_application/core/usecase/usecase.dart';
import 'package:notes_application/features/category/data/models/category.model.dart';
import 'package:notes_application/features/category/domain/repositories/category.dart';
import 'package:notes_application/injection.container.dart';

class CreateCategoryUseCase implements UseCase<Either, Category> {
  @override
  Future<Either> call(Category params) async {
    return sl<CategoryRepository>().createCategory(params);
  }
}