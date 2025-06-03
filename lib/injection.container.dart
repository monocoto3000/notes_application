import 'package:get_it/get_it.dart';
import 'package:notes_application/core/network/dio.client.dart';
import 'package:notes_application/features/auth/data/datasources/auth.api.service.dart';
import 'package:notes_application/features/auth/data/repositories/auth.repository.dart';
import 'package:notes_application/features/auth/domain/repositories/auth.dart';
import 'package:notes_application/features/auth/domain/usecases/login.usecase.dart';
import 'package:notes_application/features/auth/domain/usecases/register.usecase.dart';
import 'package:notes_application/features/auth/presentation/cubit/login/auth_cubit.dart';
import 'package:notes_application/features/auth/presentation/cubit/register/auth_cubit.dart';
import 'package:notes_application/features/category/data/datasources/category.api.service.dart';
import 'package:notes_application/features/notes/data/datasources/notes.api.service.dart';
import 'package:notes_application/features/category/data/repositories/category.repository.dart';
import 'package:notes_application/features/notes/data/repositories/notes.repository.dart';
import 'package:notes_application/features/category/domain/repositories/category.dart';
import 'package:notes_application/features/notes/domain/repositories/notes.dart';
import 'package:notes_application/features/category/domain/usecases/createCategory.usecase.dart';
import 'package:notes_application/features/category/domain/usecases/deleteCategory.usecase.dart';
import 'package:notes_application/features/category/domain/usecases/getAllCat.usecase.dart';
import 'package:notes_application/features/category/domain/usecases/getCatById.usecase.dart';
import 'package:notes_application/features/category/domain/usecases/updateCategory.usecase.dart';
import 'package:notes_application/features/notes/domain/usecases/createNote.usecase.dart';
import 'package:notes_application/features/notes/domain/usecases/deleteNote.usecase.dart';
import 'package:notes_application/features/notes/domain/usecases/getAllNotes.usecase.dart';
import 'package:notes_application/features/notes/domain/usecases/getNoteById.usecase.dart';
import 'package:notes_application/features/notes/domain/usecases/getNotesByCat.usecase.dart';
import 'package:notes_application/features/notes/domain/usecases/updateNote.usecase.dart';
import 'package:notes_application/features/notes/presentation/cubit/createNote/create.notes_cubit.dart';
import 'package:notes_application/features/notes/presentation/cubit/detailsNote/details.notes_cubit.dart';
import 'package:notes_application/features/notes/presentation/cubit/notes/notes_cubit.dart';
import 'package:notes_application/features/notes/presentation/cubit/updateNotes/update.notes_cubit.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  // Auth dependencies
  sl.registerSingleton<AuthApiService>(
    AuthApiServiceImpl()
  );
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl()
  );

  // Register use cases
  sl.registerSingleton<RegisterUseCase>(
    RegisterUseCase()
  );
  sl.registerFactory(() => AuthCubitRegister(sl<RegisterUseCase>()));
  
  // Login use case
  sl.registerSingleton<LoginUseCase>(
    LoginUseCase()
  );
    sl.registerFactory(() => AuthCubitLogin(sl<LoginUseCase>()));

  // Notes dependencies
  sl.registerSingleton<NoteApiService>(
    NoteApiServiceImpl()
  );

  sl.registerSingleton<NoteRepository>(
    NoteRepositoryImpl()
  );

  // Notes use cases
  sl.registerSingleton<CreateNoteUseCase>(
    CreateNoteUseCase()
  ); 
  sl.registerSingleton<UpdateNoteUseCase>(
    UpdateNoteUseCase()
  );
  sl.registerSingleton<DeleteNoteUseCase>(
    DeleteNoteUseCase()
  );
  sl.registerSingleton<GetAllNotesUseCase>(
    GetAllNotesUseCase()
  );
  sl.registerSingleton<GetNoteByIdUseCase>(
    GetNoteByIdUseCase()
  );
  sl.registerSingleton<GetNotesByCatUseCase>(
    GetNotesByCatUseCase()
  );

  // Create Notes cubit
  sl.registerFactory(() => CreateNotesCubit(
    createNoteUseCase: sl<CreateNoteUseCase>(),
    getAllCategoriesUseCase: sl<GetAllCategoriesUseCase>(),
  ));

  // Category dependencies
  sl.registerSingleton<CategoryApiService>(
    CategoryApiServiceImpl()
  );
  sl.registerSingleton<CategoryRepository>(
    CategoryRepositoryImpl()
  );

  // Category use cases
  sl.registerSingleton<CreateCategoryUseCase>(
    CreateCategoryUseCase()
  );
  sl.registerSingleton<UpdateCategoryUseCase>(
    UpdateCategoryUseCase()
  );
  sl.registerSingleton<DeleteCategoryUseCase>(
    DeleteCategoryUseCase()
  );
  sl.registerSingleton<GetAllCategoriesUseCase>(
    GetAllCategoriesUseCase()
  );
  sl.registerSingleton<GetCategoryByIdUseCase>(
    GetCategoryByIdUseCase()
  );

  // Notes Cubit
  sl.registerFactory(() => NotesCubit(
    getAllNotes: sl<GetAllNotesUseCase>(),
    getNotesByCategory: sl<GetNotesByCatUseCase>(),
    getAllCategories: sl<GetAllCategoriesUseCase>(),
  ));

  // Notes Details Cubit
  sl.registerFactory(() => NoteDetailsCubit(
    getNoteById: sl<GetNoteByIdUseCase>(),
    deleteNote: sl<DeleteNoteUseCase>(),
  ));

  // Notes Update Cubit
  sl.registerFactory(() => UpdateNotesCubit(
    getAllCategoriesUseCase: sl<GetAllCategoriesUseCase>(),
    getNoteByIdUseCase: sl<GetNoteByIdUseCase>(),
    updateNoteUseCase: sl<UpdateNoteUseCase>(),
  ));

}