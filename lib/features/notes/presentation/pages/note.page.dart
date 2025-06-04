import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_application/features/category/data/models/category.model.dart';
import 'package:notes_application/features/notes/data/models/notes.model.dart';
import 'package:notes_application/features/notes/presentation/cubit/notes/notes_cubit.dart';
import 'package:notes_application/features/notes/presentation/widgets/notes/note.dart';
import 'package:notes_application/injection.container.dart';
import 'package:notes_application/features/category/domain/usecases/getAllCat.usecase.dart';
import 'package:notes_application/features/notes/domain/usecases/getAllNotes.usecase.dart';
import 'package:notes_application/features/notes/domain/usecases/getNotesByCat.usecase.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late NotesCubit _notesCubit;

  @override
  void initState() {
    super.initState();
    _notesCubit = NotesCubit(
      getAllNotes: sl<GetAllNotesUseCase>(),
      getNotesByCategory: sl<GetNotesByCatUseCase>(),
      getAllCategories: sl<GetAllCategoriesUseCase>(),
    );
    _notesCubit.loadData();
  }

  @override
  void dispose() {
    _notesCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _notesCubit,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<NotesCubit, NotesState>(
          listener: (context, state) {
            if (state is NotesError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is NotesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NotesLoaded) {
              return _buildNotesView(state);
            } else if (state is NotesError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/createNote');
          },
          backgroundColor: Colors.black,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildNotesView(NotesLoaded state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 56),
          const Text(
            'Notas',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 20),
          _buildCategoryFilters(state),
          const SizedBox(height: 20),
          buildNotesList(state.notes),
        ],
      ),
    );
  }

  Widget _buildCategoryFilters(NotesLoaded state) {
    return SizedBox(
      height: 30,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildCategoryFilter(
            null,
            'Todos',
            state.selectedCategory == null,
            Colors.grey,
          ),
          const SizedBox(width: 5),
          ...state.categories.map((category) => _buildCategoryFilter(
                category,
                category.name,
                state.selectedCategory?.id == category.id,
                getCategoryColor(category.color),
              )),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter(
    Category? category,
    String label,
    bool isSelected,
    Color color,
  ) {
    return GestureDetector(
      onTap: () => _notesCubit.selectCategory(category),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? color : color.withOpacity(0.5),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : color,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget buildNotesList(List<Note> notes) {
    if (notes.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 40),
          child: Text('No hay notas para mostrar'),
        ),
      );
    }
    return Column(
      children: notes.map((note) => buildNoteCard(
        note,
        () async {
          final result = await Navigator.of(context).pushNamed(
            '/noteDetails',
            arguments: note.id,
          );

          if (result == true) {
            _notesCubit.loadData();
          }
        },
      )).toList(),
    );
  }
}