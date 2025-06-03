import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_application/features/auth/data/models/request.model.dart';
import 'package:notes_application/injection.container.dart';
import '../cubit/register/auth_cubit.dart';
import '../cubit/register/auth_state.dart';

class AuthPageRegister extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPageRegister> {
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
    return BlocProvider(
      create: (_) => sl<AuthCubitRegister>(),
      child: Scaffold(
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
              return Stack(
                children: [
                  Container(
                    width: 375,
                    height: 812,
                    decoration: BoxDecoration(color: Colors.white),
                  ),
                  Positioned(
                    left: 20,
                    top: 94,
                    child: Text(
                      'Crear cuenta',
                      style: TextStyle(fontSize: 30, fontFamily: 'Karla', fontWeight: FontWeight.w800),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 180,
                    child: Text(
                      'Correo',
                      style: TextStyle(fontSize: 17, fontFamily: 'Karla', fontWeight: FontWeight.w700),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 210,
                    child: SizedBox(
                      width: 335,
                      child: TextField(
                        controller: emailController,
                        enabled: state is! AuthLoading,
                        decoration: InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 258,
                    child: Text(
                      'Contraseña',
                      style: TextStyle(fontSize: 17, fontFamily: 'Karla', fontWeight: FontWeight.w700),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 288,
                    child: SizedBox(
                      width: 335,
                      child: TextField(
                        controller: passController,
                        enabled: state is! AuthLoading,
                        obscureText: true,
                        decoration: InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 122,
                    top: 357,
                    child: GestureDetector(
                      onTap: state is AuthLoading ? null : () {
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
                            password: passController.text.trim()
                          )
                        );
                      },
                      child: Container(
                        width: 132,
                        height: 36,
                        decoration: ShapeDecoration(
                          color: state is AuthLoading ? Colors.grey : Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Center(
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
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 122,
                    top: 405, 
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('/login');
                      },
                      child: Container(
                        width: 132,
                        height: 36,
                        decoration: ShapeDecoration(
                          color: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Cancelar',
                            style: TextStyle(
                              color: Colors.black, 
                              fontSize: 15, 
                              fontWeight: FontWeight.w700
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 56,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: ShapeDecoration(
                        color: Colors.black,
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}