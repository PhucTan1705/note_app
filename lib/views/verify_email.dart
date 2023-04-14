import 'package:flutter/material.dart';
import 'package:project_23/constants/routes.dart';
import 'package:project_23/service/auth/aut_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify email'),),
      body: Column(children: [
          const Text("Xin hãy kiểm tra gmail để xác nhận email"),
          const Text("Nếu không nhận được email, xin nhấn nút này"),
          TextButton(onPressed: () async {
            await AuthService.firebase().sendEmailVerification();
          }, child: const Text('Send email verification')),

          TextButton(onPressed: () async {
            await AuthService.firebase().logOut();
            Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, 
            (route) => false);
          }, child: const Text("Thoát"))

        ]
      ),
    );
  }
} 