import 'package:notes_application/core/usecase/usecase.dart';
import 'package:notes_application/features/category/data/models/category.model.dart';
import 'package:notes_application/features/category/domain/repositories/category.dart';
import 'package:notes_application/injection.container.dart';

class GetCategoryByIdUseCase implements UseCase<Category, int> {
  @override
  Future<Category> call(int params) async {
    return sl<CategoryRepository>().getCategoryById(params);
  }
}