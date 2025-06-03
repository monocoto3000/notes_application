import 'package:dartz/dartz.dart';
import 'package:notes_application/core/usecase/usecase.dart';
import 'package:notes_application/features/category/data/models/category.model.dart';
import 'package:notes_application/features/category/domain/repositories/category.dart';
import 'package:notes_application/injection.container.dart';

class UpdateCategoryUseCase implements UseCase<Either, Tuple2<int, Category>> {
  @override
  Future<Either> call(Tuple2<int, Category> params) async {
    return sl<CategoryRepository>().updateCategory(params.value1, params.value2);
  }
}