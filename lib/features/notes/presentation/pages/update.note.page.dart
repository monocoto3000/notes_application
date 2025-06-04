import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_application/features/category/data/models/category.model.dart';
import 'package:notes_application/features/notes/presentation/cubit/updateNotes/update.notes_cubit.dart';
import 'package:notes_application/features/notes/presentation/widgets/createNote/category_chip.dart';
import 'package:notes_application/features/notes/presentation/widgets/createNote/note_text_field.dart';
import 'package:notes_application/injection.container.dart';

class UpdateNotePage extends StatefulWidget {
  const UpdateNotePage({super.key});

  @override
  State<UpdateNotePage> createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  int? _selectedCategoryId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args is int) {
      print(args.runtimeType);
      final int noteId = args;
      context.read<UpdateNotesCubit>().loadNoteAndCategories(noteId);
    } else {
      print("Error: no se recibió un noteId válido.");
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateNotesCubit, UpdateNotesState>(
      listener: (context, state) {
        if (state is NoteUpdatedSuccess) {
          Navigator.pop(context, state.note);
        } else if (state is EditNotesError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is EditCategoriesLoaded) {
          _titleController.text = state.note.title;
          _contentController.text = state.note.content;
          _selectedCategoryId = state.note.categoryId;
        }
      },
      builder: (context, state) {
        if (state is EditCategoriesLoaded) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: _buildForm(state.categories),
          );
        } else if (state is EditNotesLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is EditNotesError) {
          return Scaffold(
            body: Center(child: Text(state.message)),
          );
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget _buildForm(List<Category> categories) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 56),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 28,
                height: 28,
                decoration: const ShapeDecoration(
                  color: Colors.black,
                  shape: OvalBorder(),
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white, size: 16),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Editar nota',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontFamily: 'Karla',
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 30),
            NoteTextField(
              label: 'Título',
              controller: _titleController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa un título';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            const Text(
              'Categoría',
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontFamily: 'Karla',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: categories.map((category) {
                return CategoryChip(
                  label: category.name,
                  color: _parseColor(category.color),
                  isSelected: _selectedCategoryId == category.id,
                  onTap: () {
                    setState(() {
                      _selectedCategoryId = category.id;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            NoteTextField(
              label: 'Contenido',
              controller: _contentController,
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa el contenido';
                }
                return null;
              },
            ),
            const SizedBox(height: 40),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  _saveNote();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 10),
                ),
                child: const Text(
                  'Guardar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Karla',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _parseColor(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    return Color(int.parse("0xFF$hexColor"));
  }

  void _saveNote() {
    final int noteId = ModalRoute.of(context)!.settings.arguments as int;
    if (_formKey.currentState!.validate() && _selectedCategoryId != null) {
      context.read<UpdateNotesCubit>().updateNote(
            noteId: noteId,
            title: _titleController.text,
            content: _contentController.text,
            categoryId: _selectedCategoryId!,
          );
    } else if (_selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor selecciona una categoría')),
      );
    }
  }
}