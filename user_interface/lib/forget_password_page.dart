import "package:flutter/material.dart";
import "login_page.dart";
import "change_password_page.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ForgetPasswordPage(),
    );
  }
}

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});
  static final emailController = TextEditingController();
  static final lastRememberedPasswordController = TextEditingController();
  static final newPasswordController = TextEditingController();
  static final newPasswordConfirmController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 50),
                    const Icon(
                      Icons.question_mark_outlined,
                      size: 100,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Forgot Password ?",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: emailController,
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
                        hintText: "Enter Email",
                        hintStyle: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: lastRememberedPasswordController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.question_mark_outlined),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Enter Last Remembered Password",
                        hintStyle: TextStyle(color: Colors.grey[500]),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: newPasswordController,
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
                        hintText: "Enter New Password",
                        hintStyle: TextStyle(color: Colors.grey[500]),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: newPasswordConfirmController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.password_sharp),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Confirm New Password",
                        hintStyle: TextStyle(color: Colors.grey[500]),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        MaterialButton(
                          child: const Text(
                              "Remember Your Passoword?\nChange Your Password"),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ChangePasswordPage()));
                          },
                        ),
                        MaterialButton(
                          child: const Text("Login"),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      child: const Text(
                        "Send Activation Email",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      onPressed: () {
                        var email = emailController.text;
                        var rememberedPassword =
                            lastRememberedPasswordController.text;
                        var newPassword = newPasswordController.text;
                        var confirm = newPasswordConfirmController.text;

                        if (email.isNotEmpty &&
                            rememberedPassword.isNotEmpty &&
                            newPassword.isNotEmpty &&
                            confirm.isNotEmpty) {
                          if ((rememberedPassword != newPassword) &&
                              (rememberedPassword != confirm) &&
                              (newPassword == confirm)) {
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
                                        lastRememberedPasswordController
                                            .clear();
                                        newPasswordController.clear();
                                        newPasswordConfirmController.clear();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } else if ((rememberedPassword != newPassword) &&
                              (rememberedPassword != confirm) &&
                              (newPassword != confirm)) {
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
                                  content:
                                      const Text("Password's are different!"),
                                  actions: <Widget>[
                                    MaterialButton(
                                        child: const Text("Go Back"),
                                        onPressed: () =>
                                            Navigator.pop(context)),
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
                                        lastRememberedPasswordController
                                            .clear();
                                        newPasswordController.clear();
                                        newPasswordConfirmController.clear();
                                      },
                                    ),
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
                                content: const Text("All entities are empty."),
                                actions: <Widget>[
                                  MaterialButton(
                                    child: const Text("Ok"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      emailController.clear();
                                      lastRememberedPasswordController.clear();
                                      newPasswordController.clear();
                                      newPasswordConfirmController.clear();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
