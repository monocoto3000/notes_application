import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_application/features/notes/presentation/cubit/detailsNote/details.notes_cubit.dart';
import 'package:notes_application/injection.container.dart';

class NoteDetailsPage extends StatelessWidget {
  const NoteDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int noteId = ModalRoute.of(context)!.settings.arguments as int;

    return BlocProvider(
      create: (_) => sl<NoteDetailsCubit>()..loadNote(noteId),
      child: BlocBuilder<NoteDetailsCubit, NoteDetailsState>(
        builder: (context, state) {
          if (state is NoteDeleted) {
            Navigator.of(context).pop(true);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nota eliminada correctamente')),
            );
          }
          if (state is NoteDetailsLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state is NoteDetailsError) {
            return Scaffold(
              body: Center(child: Text(state.message)),
            );
          }
          if (state is NoteDetailsLoaded) {
            final note = state.note;
            final color = _getCategoryColor(note.categoryColor);
            final size = MediaQuery.of(context).size;
            return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed('/notes');
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: ShapeDecoration(
                                color: color,
                                shape: const OvalBorder(),
                              ),
                              child: const Icon(Icons.arrow_back, color: Colors.white),
                            ),
                          ),
                          const Spacer(),
                          
                          GestureDetector(
                            onTap: () {
                              context.read<NoteDetailsCubit>().deleteNote(note.id);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'Eliminar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Karla',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          
                          GestureDetector(
                            onTap: () async {
                              final result = await Navigator.of(context).pushNamed(
                                '/updateNote',
                                arguments: note.id,
                              );
                              if (result != null) {
                                context.read<NoteDetailsCubit>().loadNote(note.id);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'Editar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Karla',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      
                      Text(
                        note.title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontFamily: 'Karla',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      Align(
                        alignment: Alignment.centerRight,
                        child: Chip(
                          backgroundColor: color,
                          label: Text(
                            '${note.createdAt.day.toString().padLeft(2, '0')}-${note.createdAt.month.toString().padLeft(2, '0')}-${note.createdAt.year}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontFamily: 'Karla',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      Text(
                        note.content,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Karla',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Color _getCategoryColor(String colorString) {
    final cleaned = colorString.replaceAll('#', '');
    return Color(int.parse('0xFF$cleaned'));
  }
}
