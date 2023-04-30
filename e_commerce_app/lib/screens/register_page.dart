import "../service/auth.dart";
import "package:flutter/material.dart";
import "login_page.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  static final firstNameController = TextEditingController();
  static final lastNameController = TextEditingController();
  static final emailController = TextEditingController();
  static final passwordController = TextEditingController();
  static final confirmController = TextEditingController();

  static final _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 15.0, right: 15.0, top: 15, bottom: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 50),
              const Icon(
                Icons.app_registration_outlined,
                size: 100,
              ),
              const SizedBox(height: 10),
              const Text(
                "Register to App",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: firstNameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.contact_emergency),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  labelText: "First Name",
                  labelStyle: TextStyle(color: Colors.purple),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: lastNameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.contact_emergency_outlined),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  labelText: "Last Name",
                  labelStyle: TextStyle(color: Colors.purple),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.mail),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.purple),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.purple),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: confirmController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  labelText: "Confirm Password",
                  labelStyle: TextStyle(color: Colors.purple),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                child: const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  var firstName = firstNameController.text;
                  var lastName = lastNameController.text;
                  var email = emailController.text;
                  var password = passwordController.text;
                  var confirm = confirmController.text;

                  if (firstName.isNotEmpty &&
                      lastName.isNotEmpty &&
                      email.isNotEmpty &&
                      password.isNotEmpty &&
                      confirm.isNotEmpty &&
                      (password.length > 6)) {
                    if (password == confirm) {
                      _authService.createUser(
                          firstName, lastName, email, password);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Row(
                              children: [
                                Icon(Icons.info),
                                Text(
                                  " Success ",
                                ),
                              ],
                            ),
                            content: const Text("Successfully Registered"),
                            actions: <Widget>[
                              MaterialButton(
                                  child: const Text("Let's start"),
                                  onPressed: () => Navigator.pop(context)),
                            ],
                          );
                        },
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Row(
                              children: [
                                Icon(Icons.warning),
                                Text(
                                  " Integrity Error",
                                ),
                              ],
                            ),
                            content: const Text(
                                "Password's are different or you entered password length which is so weak.\nPlease make sure that you entered password which is longer than 6 characters and you entered password and confirm correctly."),
                            actions: <Widget>[
                              MaterialButton(
                                  child: const Text("Go Back"),
                                  onPressed: () => Navigator.pop(context)),
                            ],
                          );
                        },
                      );
                    }
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Row(
                            children: [
                              Icon(Icons.warning),
                              Text(
                                "Error",
                              ),
                            ],
                          ),
                          content: const Text(
                              "There Occured an Error Please Check Your Entitites"),
                          actions: <Widget>[
                            MaterialButton(
                                child: const Text("Go Back"),
                                onPressed: () => Navigator.pop(context)),
                          ],
                        );
                      },
                    );
                  }
                  firstNameController.clear();
                  lastNameController.clear();
                  emailController.clear();
                  passwordController.clear();
                  confirmController.clear();
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    child: const Text(
                        "You already have an account?\n                  Login here"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
