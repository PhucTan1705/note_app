import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_23/constants/routes.dart';
import 'package:project_23/service/auth/aut_service.dart';
import 'package:project_23/service/auth/auth_exceptions.dart';
import 'package:project_23/service/auth/bloc/auth_bloc.dart';
import 'package:project_23/service/auth/bloc/auth_event.dart';
import '../utilities/dialog/error_dialog.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Nhập Email'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: 'Nhập Password'),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                context.read<AuthBloc>().add(
                  AuthEventLogIn(
                    email, 
                    password,
                  )
                );
              } on UserNotFoundAuthException {
                await showErrorDialog(
                  context,
                  "Khong tim thay nguoi dung",
                );
              } on WrongPasswordAuthException {
                await showErrorDialog(
                  context,
                  'Sai Mật Khẩu',
                );
              } on GenericAuthException {
                await showErrorDialog(
                  context,
                  "Lỗi xác thực",
                );
              }
            },
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
            child: const Text('Chưa Đăng Kí? Đăng Kí Ngay'),
          )
        ],
      ),
    );
  }
}
