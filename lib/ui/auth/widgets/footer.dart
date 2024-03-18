import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginFooter extends StatelessWidget {
  LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: 10,
      ),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        TextButton(
          onPressed: () {},
          child: Text(
            "忘记密码",
            style: TextStyle(
              color: Theme.of(context).hintColor,
            ),
          ),
        )
      ]),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              context.goNamed('register');
            },
            child: Text(
              "立即注册",
              style: TextStyle(
                color: isDarkMode(context)
                    ? Theme.of(context).primaryColorLight
                    : Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Image.asset('assets/logos/google.png'),
            ),
            onTap: () => _googleLogin(),
          ),
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
              ),
              child: Image.asset('assets/logos/github.png'),
            ),
            onTap: () => _githubLogin(),
          )
        ],
      ),
    ]);
  }

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  final supabase = Supabase.instance.client;

  Future<void> _googleLogin() async {
    // const ohresult = await supabase.auth.signInWithOAuth(OAuthProvider.google);
    // print(ohresult);
  }

  Future<void> _githubLogin() async {
    try {
      final result = await supabase.auth.signInWithOAuth(
        OAuthProvider.github,
      );
      print(result);
    } catch (e) {
      print(e);
    }
  }
}
