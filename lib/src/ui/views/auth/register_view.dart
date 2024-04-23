import 'package:ayna/src/bloc/auth/auth_bloc.dart';
import 'package:ayna/src/bloc/auth/auth_event.dart';
import 'package:ayna/src/bloc/auth/auth_state.dart';
import 'package:ayna/src/extension/custom_color_scheme.dart';
import 'package:ayna/src/ui/shared/ui_helpers.dart';
import 'package:ayna/src/ui/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView(this.value, {super.key});

  final String value;

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _emailTech = TextEditingController();

  final _passwordTech = TextEditingController();

  final _nameTech = TextEditingController();

  final _authBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Anya Web Chat',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (_) => _authBloc,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (widget.value == "Sign Up")
                    SizedBox(
                      width: 500,
                      child: TextFormField(
                        controller: _nameTech,
                        autofocus: true,
                        keyboardType: TextInputType.name,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.black),
                        decoration: const InputDecoration(
                          hintText: 'Name',
                          hintStyle: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w700),
                          fillColor: Colors.black12,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(
                              width: 0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (widget.value == "Sign Up") verticalSpaceRegular,
                  SizedBox(
                    width: 500,
                    child: TextFormField(
                      controller: _emailTech,
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.black),
                      decoration: const InputDecoration(
                        hintText: 'Email Address',
                        hintStyle: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w700),
                        fillColor: Colors.black12,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(
                            width: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  verticalSpaceRegular,
                  SizedBox(
                    width: 500,
                    child: TextFormField(
                      controller: _passwordTech,
                      autofocus: true,
                      keyboardType: TextInputType.visiblePassword,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.black),
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w700),
                        fillColor: Colors.black12,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(
                            width: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  verticalSpaceLarge,
                  SizedBox(
                    width: 200,
                    child: BlocListener<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state.status == Status.loading) {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(const SnackBar(
                                content: Text('Please Wait...')));
                        }
                        if (state.status == Status.success) {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                                const SnackBar(content: Text('Success')));
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => HomeView()),
                            (Route<dynamic> route) => false,
                          );
                        }
                        if (state.status == Status.error) {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(const SnackBar(
                                content: Text('Some error occured!!!')));
                        }
                      },
                      child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (authContext, authState) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(70),
                            textStyle: const TextStyle(fontSize: 20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: (widget.value == 'Login')
                              ? () => authContext.read<AuthBloc>().add(Login(
                                  email: _emailTech.text,
                                  password: _passwordTech.text))
                              : () => authContext.read<AuthBloc>().add(SignUp(
                                  email: _emailTech.text,
                                  password: _passwordTech.text,
                                  name: _nameTech.text)),
                          child: Text(widget.value),
                        );
                      }),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
