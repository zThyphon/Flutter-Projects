import "../forget_password_page.dart";
import "../register_page.dart";
import "package:flutter/material.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangePasswordPage(),
    );
  }
}

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  static final emailController = TextEditingController();
  static final oldPasswordController = TextEditingController();
  static final newPasswordController = TextEditingController();
  static final newPasswordConfirmController = TextEditingController();

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
                Icons.key,
                size: 100,
              ),
              const SizedBox(height: 10),
              const Text(
                "Change Password",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
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
                controller: oldPasswordController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  labelText: "Old Password",
                  labelStyle: TextStyle(color: Colors.purple),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: newPasswordController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  labelText: "New Password",
                  labelStyle: TextStyle(color: Colors.purple),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: newPasswordConfirmController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  labelText: "Confirm New Password",
                  labelStyle: TextStyle(color: Colors.purple),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MaterialButton(
                    child: const Text("Register"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()));
                    },
                  ),
                  MaterialButton(
                    child: const Text("Forgot Password?"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ForgetPasswordPage()));
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text(
                  "Change Password",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  var email = emailController.text;
                  var oldPassword = oldPasswordController.text;
                  var newPassword = newPasswordController.text;
                  var confirm = newPasswordConfirmController.text;

                  if (email.isNotEmpty &&
                      oldPassword.isNotEmpty &&
                      newPassword.isNotEmpty &&
                      confirm.isNotEmpty) {
                    if ((oldPassword != newPassword) &&
                        (oldPassword != confirm)) {
                      if (confirm == newPassword) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Row(
                                children: [
                                  Icon(Icons.info),
                                  Text(
                                    " Info",
                                  ),
                                ],
                              ),
                              content: const Text(
                                  "Password Change Request has been sent to your email."),
                              actions: <Widget>[
                                MaterialButton(
                                  child: const Text("Ok"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    emailController.clear();
                                    oldPasswordController.clear();
                                    newPasswordController.clear();
                                    newPasswordConfirmController.clear();
                                  },
                                ),
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
                              content: const Text("Password's are different!"),
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
                                Icon(Icons.error),
                                Text(
                                  " Error",
                                ),
                              ],
                            ),
                            content: const Text(
                                "There occured an error.\nCheck your entities."),
                            actions: <Widget>[
                              MaterialButton(
                                child: const Text("Ok"),
                                onPressed: () {
                                  Navigator.pop(context);
                                  emailController.clear();
                                  oldPasswordController.clear();
                                  newPasswordController.clear();
                                  newPasswordConfirmController.clear();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
