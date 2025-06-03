import 'package:notes_application/core/usecase/noparams.dart';
import 'package:notes_application/core/usecase/usecase.dart';
import 'package:notes_application/features/category/data/models/category.model.dart';
import 'package:notes_application/features/category/domain/repositories/category.dart';
import 'package:notes_application/injection.container.dart';

class GetAllCategoriesUseCase implements UseCase<List<Category>, NoParams> {
  @override
  Future<List<Category>> call(NoParams params) async {
    return sl<CategoryRepository>().getAllCategories();
  }
}