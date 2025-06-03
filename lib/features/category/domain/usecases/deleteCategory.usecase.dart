import 'package:dartz/dartz.dart';
import 'package:notes_application/core/usecase/usecase.dart';
import 'package:notes_application/features/category/domain/repositories/category.dart';
import 'package:notes_application/injection.container.dart';

class DeleteCategoryUseCase implements UseCase<Either, int> {
  @override
  Future<Either> call(int params) async {
    return sl<CategoryRepository>().deleteCategory(params);
  }
}