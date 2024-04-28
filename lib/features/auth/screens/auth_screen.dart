import 'package:amazon_app/common/widgets/custom_button.dart';
import 'package:amazon_app/common/widgets/custom_textfield.dart';
import 'package:amazon_app/constants/global_variables.dart';
import 'package:amazon_app/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

enum Auth{
  signIn,
  signUp,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signUp;
  final _signInFormKey = GlobalKey<FormState>();
  final _signUpFormKey = GlobalKey<FormState>();
  final _authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                  color: GlobalVariables.secondaryColor,
                ),
              ),
            ),
            ListTile(
              tileColor: _auth == Auth.signUp 
              ? GlobalVariables.backgroundColor
              : GlobalVariables.greyBackgroundColor,
              title: Text(
                'Create Account',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Radio(
                activeColor: GlobalVariables.secondaryColor,
                value: Auth.signUp,
                groupValue: _auth,
                onChanged: (Auth? val){
                  setState(() {
                    _auth = val!;
                  });
                },
              ),
              
            ),

            if(_auth == Auth.signUp)
              Container(
                color: GlobalVariables.backgroundColor,
                child: Form(
                  key: _signUpFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _nameController, 
                        hint: 'Name'
                      ),
                      CustomTextField(
                        controller: _emailController, 
                        hint: 'Email'
                      ),
                      CustomTextField(
                        controller: _passController, 
                        hint: 'Password',
                        isPass: true,
                      ),
                      CustomButton(
                        text: 'Sign Up', 
                        onTap: () {
                          if(_signUpFormKey.currentState!.validate()){
                            _authService.signUp(
                              context: context, 
                              name: _nameController.text, 
                              email: _emailController.text, 
                              password: _passController.text
                            );
                          }
                        }
                      )
                    ],
                  )
                ),
              ),

            ListTile(
              tileColor: _auth == Auth.signIn 
              ? GlobalVariables.backgroundColor
              : GlobalVariables.greyBackgroundColor,
              title: Text(
                'Sign In',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Radio(
                activeColor: GlobalVariables.secondaryColor,
                value: Auth.signIn,
                groupValue: _auth,
                onChanged: (Auth? val){
                  setState(() {
                    _auth = val!;
                  });
                },
              ),
              
            ),

            if(_auth == Auth.signIn)
              Container(
                color: GlobalVariables.backgroundColor,
                child: Form(
                  key: _signInFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _emailController, 
                        hint: 'Email'
                      ),
                      CustomTextField(
                        controller: _passController, 
                        hint: 'Password',
                        isPass: true,
                      ),
                      CustomButton(
                        text: 'Sign In', 
                        onTap: () {
                          if(_signInFormKey.currentState!.validate()){
                            _authService.signIn(
                              context: context, 
                              email: _emailController.text, 
                              password: _passController.text
                            );
                          }
                            
                        }
                      )
                    ],
                  )
                ),
              ),

          ]
        )
      )
    );
  }
}