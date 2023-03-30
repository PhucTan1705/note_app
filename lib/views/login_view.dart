import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



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
    _password=TextEditingController();// TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();// TODO: implement dispose
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
                                print(userCredential);
    
                          } on FirebaseAuthException catch (e) {
                            if (e.code=='user-not-found') {
                              print('Khong tim thay nguoi dung');
                            } else if (e.code=='wrong-password'){
                              print('Sai mat khau');
                              
                            }
                          } 
                          
                          
                        },
                      child: const Text('Login'), 
                      
                      ),
                      TextButton(
                        onPressed:() {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/register', (route) => false);
                        },
                        child: Text('Chưa Đăng Kí? Đăng Kí Ngay'),
                      )
                    ],
                  ),
    );
  }

  
}