import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_23/service/auth/bloc/auth_bloc.dart';
import 'package:project_23/service/auth/bloc/auth_event.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify email'),
      ),
      body: Column(children: [
        const Text("Xin hãy kiểm tra gmail để xác nhận email"),
        const Text("Nếu không nhận được email, xin nhấn nút này"),
        TextButton(
            onPressed: () {
              context.read<AuthBloc>().add(
                const AuthEventSendEmailVerification(),
              );
            },
            child: const Text('Gửi Email Xác Nhận')),
        TextButton(
            onPressed: () async {
              context.read<AuthBloc>().add(
                const AuthEventLogOut(),
              );
            },
            child: const Text("Thoát"))
      ]),
    );
  }
}
