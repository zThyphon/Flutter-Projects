import "package:flutter/material.dart";
import "../screens/home_screen.dart";
import "../style/app_style.dart";

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.yellow,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 250),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 60,
                    child: Image.asset(
                      "images/notebook.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Notebook App",
                    style: TextStyle(
                      fontSize: 28,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Open Sans",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "This application developed\n",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Open Sans",
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "by  ",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "zThyphon",
                    style: TextStyle(
                      fontSize: 20,
                      color: AppStyle.mainColor,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ));
                },
                icon: const Icon(Icons.star),
                label: const Text(
                  "Get Started",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Open Sans",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
