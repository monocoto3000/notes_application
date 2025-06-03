import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_application/features/auth/presentation/cubit/login/auth_cubit.dart';
import 'package:notes_application/features/auth/presentation/cubit/register/auth_cubit.dart';
import 'package:notes_application/features/auth/presentation/pages/login.page.dart';
import 'package:notes_application/features/auth/presentation/pages/register.page.dart';
import 'package:notes_application/features/notes/presentation/cubit/createNote/create.notes_cubit.dart';
import 'package:notes_application/features/notes/presentation/cubit/detailsNote/details.notes_cubit.dart';
import 'package:notes_application/features/notes/presentation/cubit/notes/notes_cubit.dart';
import 'package:notes_application/features/notes/presentation/cubit/updateNotes/update.notes_cubit.dart';
import 'package:notes_application/features/notes/presentation/pages/create.note.page.dart';
import 'package:notes_application/features/notes/presentation/pages/note.details.page.dart';
import 'package:notes_application/features/notes/presentation/pages/note.page.dart';
import 'package:notes_application/features/notes/presentation/pages/update.note.page.dart';
import 'package:notes_application/injection.container.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupServiceLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notitas App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => BlocProvider(
          create: (_) => sl<AuthCubitLogin>(),
          child: LoginPage(),
        ),
        '/register': (context) => BlocProvider(
          create: (_) => sl<AuthCubitRegister>(),
          child: AuthPageRegister(),
        ),
        '/createNote': (context) => BlocProvider(
          create: (_) => sl<CreateNotesCubit>(),
          child: CreateNotePage(),
        ),
        '/notes': (context) => BlocProvider(
          create: (_) => sl<NotesCubit>(),
          child: NotesPage(),
        ),
        '/noteDetails': (context) => BlocProvider(
          create: (_) => sl<NoteDetailsCubit>(),
          child: NoteDetailsPage(),
        ),
        '/updateNote': (context) => BlocProvider(
          create: (_) => sl<UpdateNotesCubit>(),
          child: UpdateNotePage(),
        ),
      },
    );
  }
}

