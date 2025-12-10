import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karaoke_manage/core/widgets/base_statefull_widget.dart';
import 'package:karaoke_manage/core/widgets/base_statefull_widget_state.dart';
import 'package:karaoke_manage/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:karaoke_manage/features/auth/presentation/bloc/auth_state.dart';

class LoginScreen extends BaseStatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseStatefulWidgetState<LoginScreen> {
  final _username = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _username.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      final username = _username.text.trim();
      final password = _passwordController.text.trim();
      context.read<AuthBloc>().add(AuthLoginRequested(username, password));
    }
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthErrorState) {
            showAlertDialog(title: "Lỗi", content: state.error);
          } else if (state is AuthAuthenticatedState) {
            final role = state.user.role.toLowerCase();
            if (role == 'admin' || role == 'manager' || role == 'cashier') {
              Navigator.of(context).pushReplacementNamed('/manager_home');
            } else {
              Navigator.of(context).pushReplacementNamed('/staff_home');
            }
          }
        },
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 450),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Icon(
                            Icons.lock_outline_rounded,
                            size: 100,
                            color: Colors.blue,
                          ),

                          verticalSpace(30),
                          const Text(
                            'Welcome Back',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          verticalSpace(20),

                          TextFormField(
                            controller: _username,
                            decoration: const InputDecoration(
                              labelText: 'Email or Username',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.supervised_user_circle),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email or username';
                              }
                              return null;
                            },
                          ),

                          verticalSpace(16),

                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.lock_outline_rounded),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                            obscureText: _isPasswordVisible,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          verticalSpace(30),

                          ElevatedButton(
                            onPressed: _handleLogin,
                            child: state is AuthLoadingState
                                ? const CircularProgressIndicator()
                                : const Text('Login'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
