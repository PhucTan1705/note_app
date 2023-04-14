
import 'package:flutter/material.dart';
import 'package:project_23/constants/routes.dart';
import 'package:project_23/service/auth/aut_service.dart';
import 'package:project_23/views/login_view.dart';
import 'package:project_23/views/notes_view.dart';
import 'package:project_23/views/register_view.dart';
import 'package:project_23/views/verify_email.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        loginRoute:(context) => const Login(),
        registerRoute:(context) => const RegisterView(),
        notesRoute:(context) => const NotesView(),
        verifyEmailRoute:(context) => const VerifyEmailView()
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapshot) {

            switch (snapshot.connectionState){
              
              case ConnectionState.done:
                  final user = AuthService.firebase().currentUser;
                  if(user!=null){
                    if(user.isEmailVerified){
                      return const NotesView();
                    } else {
                      return const VerifyEmailView();
                    }
                  } else{
                    return const Login();
                  }
                  //final ev=user?.emailVerified ?? false;
                  //print(user);
                  //if(ev){
                    //return const Text('Done');
                  //} else{
                   //return const VerifyEmailView();
                  //}
                  
              default: 
                  return const CircularProgressIndicator();
            }
            
        },
        
      );
  }
}







