import 'package:authenticatio_samplen/components/my_button.dart';
import 'package:authenticatio_samplen/components/text_field.dart';
import 'package:authenticatio_samplen/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final void Function() onTap;

  // Initializing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController conpassController = TextEditingController();

  // Make AuthService final since it doesn't need to be reassigned
  final AuthService _authService = AuthService();

  RegisterPage({super.key, required this.onTap});
  @override
  Widget build(BuildContext context) {
    void signUp() async {
      if (passwordController.text == conpassController.text) {
        try {
          _authService.singUpWithEmailAndPassword(
              emailController.text, passwordController.text);
        } catch (error) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text(error.toString()),
                  ));
        }
      } else {
        showDialog(
            context: context,
            builder: (context) => const AlertDialog(
                  title: Text("Passwords Dont Match"),
                ));
      }
    }

    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              //logo
              const SizedBox(
                width: 50,
              ),

              const Center(
                child: Icon(
                  Icons.airplane_ticket,
                  size: 200,
                ),
              ),
              //Text welcoming
              Text(
                "Login To See your Air Tickets",
                style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),

              //username
              MyTextField(
                controller: emailController,
                hintText: "Username",
                obscure: false,
              ),

              //password
              MyTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscure: true),
              MyTextField(
                  controller: conpassController,
                  hintText: "Confirm Password",
                  obscure: true),
              //forgot password
              const SizedBox(
                height: 10,
              ),

              const SizedBox(
                height: 20,
              ),
              MyButton(
                text: "Register",
                onTap: signUp,
              ),

              //continue with alternate
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already Have an Account?'),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
              //register
            ]),
          ),
        ));
  }
}
