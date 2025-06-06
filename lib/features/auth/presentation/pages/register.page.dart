import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_application/features/auth/data/models/request.model.dart';
import 'package:notes_application/injection.container.dart';
import '../cubit/register/auth_cubit.dart';
import '../cubit/register/auth_state.dart';

class AuthPageRegister extends StatefulWidget {
  @override
  _AuthPageRegisterState createState() => _AuthPageRegisterState();
}

class _AuthPageRegisterState extends State<AuthPageRegister> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (_) => sl<AuthCubitRegister>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<AuthCubitRegister, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Registro exitoso"),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 3),
                ),
              );
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.of(context).pushReplacementNamed('/notes');
              });
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 3),
                ),
              );
            }
          },
          child: BlocBuilder<AuthCubitRegister, AuthState>(
            builder: (context, state) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacementNamed('/login');
                              },
                              child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ) 
                        ),
                        SizedBox(height: 32),
                        Text(
                          'Crear cuenta',
                          style: TextStyle(fontSize: 30, fontFamily: 'Karla', fontWeight: FontWeight.w800),
                        ),
                        SizedBox(height: 40),
                        Text(
                          'Correo',
                          style: TextStyle(fontSize: 17, fontFamily: 'Karla', fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          controller: emailController,
                          enabled: state is! AuthLoading,
                          decoration: InputDecoration(border: OutlineInputBorder()),
                        ),
                        SizedBox(height: 24),
                        Text(
                          'Contraseña',
                          style: TextStyle(fontSize: 17, fontFamily: 'Karla', fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          controller: passController,
                          enabled: state is! AuthLoading,
                          obscureText: true,
                          decoration: InputDecoration(border: OutlineInputBorder()),
                        ),
                        SizedBox(height: 32),
                        Center(
                          child: SizedBox(
                            width: width * 0.5,
                            height: 36,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: state is AuthLoading ? Colors.grey : Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: state is AuthLoading
                                  ? null
                                  : () {
                                      if (emailController.text.trim().isEmpty) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text("Por favor ingresa tu correo")),
                                        );
                                        return;
                                      }
                                      if (passController.text.trim().isEmpty) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text("Por favor ingresa tu contraseña")),
                                        );
                                        return;
                                      }
                                      context.read<AuthCubitRegister>().register(
                                            Request(
                                              email: emailController.text.trim(),
                                              password: passController.text.trim(),
                                            ),
                                          );
                                    },
                              child: state is AuthLoading
                                  ? SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    )
                                  : Text(
                                      'Aceptar',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Center(
                          child: SizedBox(
                            width: width * 0.5,
                            height: 36,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.grey[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed('/login');
                              },
                              child: Text(
                                'Cancelar',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
