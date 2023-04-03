
import 'dart:developer' as devtools show log;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {


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
      appBar:AppBar(title: const Text('Register'),) ,
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
    
                                final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                  email: email, 
                                  password: password,
                                );
                                devtools.log(userCredential.toString());
                                print(userCredential);
    
                          } on FirebaseAuthException catch (e) {
                            if(e.code=='weak-password')
                            {
                              devtools.log('Password yeu');
                            }
                            else if(e.code=='email-already-in-use')
                            {
                              devtools.log('Email da duoc su dung');
                            }
                            else if(e.code=='invalid-email')
                            {
                              devtools.log('Email khong hop le');
                            }
                          } 
                          
                        },
                      child: const Text('Đăng Kí'), 
                      
                      ),
                      TextButton(onPressed:() {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/login', (route) => false);
                      }, child: const Text('Đã Đăng Kí? Đăng Nhập Ngay'))
                    ],
                  ),
    );  // TODO: Handle this case.
  }
}