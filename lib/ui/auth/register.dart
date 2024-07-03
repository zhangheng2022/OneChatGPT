import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/ui/auth/widgets/email_register.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("注册账户"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Image.asset(
                "assets/logos/logo.gif", // The path to your local image
                height: 70, // Optional, adjust the height as needed
                fit: BoxFit.cover, // Maintain the aspect ratio of the image
              ),
              Text(
                "ONE CHAT GPT",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  fontFamily: GoogleFonts.anton().fontFamily,
                ),
              ),
              const SizedBox(width: 20),
              const RegisterEmail(),
            ],
          ),
        ),
      ),
    );
  }
}
