import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_23/constants/routes.dart';
import '../utilities/show_error_dialog.dart';


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
    _email=TextEditingController();
    _password=TextEditingController();
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
      appBar: AppBar(title: const Text('Login'),),
      body: Column(
                    children: [
                      TextField(
                        controller: _email,
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'Nhập Email'
                        ),
                      ),
                      TextField(
                        controller: _password,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          hintText: 'Nhập Password'
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                
                          
                          final email=_email.text;
                          final password=_password.text;
                          try {
    
                                final userCredential = await  FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: email, 
                                  password: password,
                                );
                                Navigator.of(context).pushNamedAndRemoveUntil(notesRoute, (route) => false);

    
                          } on FirebaseAuthException catch (e) {
                            if (e.code=='user-not-found') {
                              showErrorDialog(context, 'Không Tìm Thấy Người Dùng');
                            } else if (e.code=='wrong-password'){
                              showErrorDialog(context, 'Sai Mật Khẩu');
                              
                            } else {
                              await showErrorDialog(context, 
                              'Error: ${e.code}');
                            }
                          } catch(e){
                           await showErrorDialog(context, 
                              e.toString());

                          } 
                          
                          
                        },
                      child: const Text('Login'), 
                      
                      ),
                      TextButton(
                        onPressed:() {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            registerRoute, (route) => false);
                        },
                        child: const Text('Chưa Đăng Kí? Đăng Kí Ngay'),
                      )
                    ],
                  ),
    );
  }

  
}

