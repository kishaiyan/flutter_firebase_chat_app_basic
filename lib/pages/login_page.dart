import 'package:authenticatio_samplen/services/auth/auth_service.dart';
import 'package:authenticatio_samplen/components/my_button.dart';
import 'package:authenticatio_samplen/components/square_tile.dart';
import 'package:authenticatio_samplen/components/text_field.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final void Function() onTap;
  Login({super.key, required this.onTap});

  void userSignIn(BuildContext context) async {
    final auth = AuthService();

    try {
      await auth.loginWithEmailAndPassword(
          usernameController.text, passwordController.text);
    } catch (e) {
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
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
                controller: usernameController,
                hintText: "Username",
                obscure: false,
              ),

              //password
              MyTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscure: true),

              //forgot password
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Forgot Password?'),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MyButton(
                text: "Sign In",
                onTap: () => userSignIn(context),
              ),

              //continue with alternate
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: Divider(
                    thickness: 0.7,
                    color: Colors.grey.shade500,
                  )),
                  const Text("Or Continue with"),
                  Expanded(
                      child: Divider(
                    thickness: 0.7,
                    color: Colors.grey.shade500,
                  ))
                ],
              ),
              const SizedBox(height: 27),
              //google and apple
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(path: "lib/images/Google logo thumbnail.png"),
                  SizedBox(
                    width: 20,
                  ),
                  SquareTile(path: "lib/images/Apple logo heart.png"),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Not a Member?'),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: const Text(
                      "Register",
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
