import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecatalog/data/datasource/local_datasource.dart';
import 'package:flutter_ecatalog/presentation/home.dart';
import 'package:flutter_ecatalog/presentation/register_page.dart';

import '../bloc/login/login_bloc.dart';
import '../data/models/request/login_request_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    checkAuth();
    super.initState();
  }

  void checkAuth() async {
    await Future.delayed(Duration(seconds: 1));
    final auth = await LocalDataSource().getToken();
    if (auth.isNotEmpty) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const HomePage();
      }));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LOGIN page'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                'Login User',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 8),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ));
                }
                if (state is LoginSuccess) {
                  LocalDataSource().saveToken(state.model.accessToken);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text('Login success '),
                    backgroundColor: Colors.green,
                  ));
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const HomePage();
                  }));
                }
              },
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state is LoginLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ElevatedButton(
                    onPressed: () {
                      final requestModel = LoginRequestModel(
                          email: emailController.text,
                          password: passwordController.text);
                      context
                          .read<LoginBloc>()
                          .add(DoLoginEvent(model: requestModel));
                    },
                    child: const Text('Login'),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const RegisterPage();
                  }));
                },
                child: Text('Belum punya akun? register'))
          ],
        ),
      ),
    );
  }
}
