import "package:firebase_auth/firebase_auth.dart";
import "register_page.dart";
import "package:flutter/material.dart";
import "../service/auth.dart";
import "main_page.dart";

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static final loginEmailController = TextEditingController();
  static final loginPasswordController = TextEditingController();
  static final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          const SizedBox(height: 60),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    const Icon(
                      Icons.login,
                      size: 100,
                    ),
                    const SizedBox(height: 50),
                    Text(
                      "Welcome to Login Page",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 15, bottom: 0),
                      child: TextFormField(
                        controller: loginEmailController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.mail),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Email",
                          hintStyle: TextStyle(color: Colors.grey[500]),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 15, bottom: 0),
                      child: TextFormField(
                        controller: loginPasswordController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.password),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.grey[500]),
                        ),
                        obscureText: true,
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () {
                        var email = loginEmailController.text;
                        var password = loginPasswordController.text;

                        if (email.isEmpty || password.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Row(
                                  children: [
                                    Icon(Icons.warning),
                                    Text(
                                      " Error",
                                    ),
                                  ],
                                ),
                                content: const Text(
                                    "Please Enter Your Email and/or Password"),
                                actions: <Widget>[
                                  MaterialButton(
                                      child: const Text("Ok"),
                                      onPressed: () => Navigator.pop(context)),
                                ],
                              );
                            },
                          );
                        } else {
                          _authService.signIn(email, password).then((user) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MainPage()));
                          });
                          User? user = FirebaseAuth.instance.currentUser;
                          if (user != null) {
                          } else {}
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        MaterialButton(
                          child: const Text("Register"),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterPage()));
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
