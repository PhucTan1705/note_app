

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

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
      appBar: AppBar(title: const Text('Đăng Kí'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
                  options: DefaultFirebaseOptions.currentPlatform,
                ),
        builder: (context, snapshot) {

            switch (snapshot.connectionState){
              
              case ConnectionState.done:
                return Column(
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
                              print(userCredential);

                        } on FirebaseAuthException catch (e) {
                          if(e.code=='weak-password')
                          {
                            print('Password yeu');
                          }
                          else if(e.code=='email-already-in-use')
                          {
                            print('Email da duoc su dung');
                          }
                          else if(e.code=='invalid-email')
                          {
                            print('Email khong hop le');
                          }
                        } 
                        
                      },
                    child: const Text('Đăng Kí'), 
                    
                    ),
                  ],
                );  // TODO: Handle this case.
                default: 
                  return const Text('Loading...');

            }
            
        },
        
      ),
    );
  }
}