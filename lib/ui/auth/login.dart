import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:one_chatgpt_flutter/widgets/circular_progress.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:one_chatgpt_flutter/ui/auth/widgets/email_login.dart';
import 'package:go_router/go_router.dart';
import 'package:one_chatgpt_flutter/utils/connectivity_checker.dart';
import 'dart:async';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _githubLogin() async {
    try {
      await supabase.auth.signInWithOAuth(
        OAuthProvider.github,
        redirectTo: 'onechatgpt://login-callback',
      );
    } catch (err) {
      debugPrint("github授权登录错误：$err");
    }
  }

  bool _googleLoginLoading = false;
  Future<void> _googleLogin() async {
    try {
      setState(() => _googleLoginLoading = true);

      final canConnectToGoogle = await ConnectivityChecker.canConnectToGoogle();

      if (!canConnectToGoogle) {
        SmartDialog.showToast('请检查网络连接或VPN是否开启');
        return;
      }

      /// Web Client ID that you registered with Google Cloud.
      const webClientId =
          '343563540047-f595uatd26cd75gjgqhfe6r9p5n6k3ih.apps.googleusercontent.com';

      /// iOS Client ID that you registered with Google Cloud.
      const iosClientId =
          '343563540047-m953d32kqfb7r6q7o48bpc8hpeter3cl.apps.googleusercontent.com';

      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: iosClientId,
        serverClientId: webClientId,
      );
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      String? accessToken = googleAuth.accessToken;
      String? idToken = googleAuth.idToken;

      if (accessToken == null || idToken == null) {
        SmartDialog.showToast('授权错误');
        return;
      }

      await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
    } catch (err) {
      SmartDialog.showToast('授权失败，请稍候再试');
    } finally {
      setState(() => _googleLoginLoading = false);
    }
  }

  bool _isCanPop = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double appHeight = MediaQuery.of(context).size.height;
    return PopScope(
      canPop: _isCanPop,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (!didPop) {
          SmartDialog.showToast('再按一次退出');
          setState(() {
            _isCanPop = true;
          });
          Timer(const Duration(seconds: 2), () {
            setState(() {
              _isCanPop = false;
            });
          });
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  "https://api.miaomc.cn/image/other/bing",
                  height: appHeight * 0.5,
                  fit: BoxFit.cover, // 保持图片的宽高比
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    'assets/images/login_header_default.jpg', //默认显示图片
                    height: appHeight * 0.5,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/logos/logo.gif",
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "你好，世界",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily:
                                          GoogleFonts.oswald().fontFamily,
                                    ),
                                  ),
                                  Text(
                                    "ONE CHAT GPT",
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontFamily:
                                          GoogleFonts.anton().fontFamily,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: FilledButton.icon(
                                icon: _googleLoginLoading
                                    ? CircularProgressWidget(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                      )
                                    : Image.asset(
                                        'assets/icons/google.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                label: const Text("Google登录"),
                                onPressed:
                                    _googleLoginLoading ? null : _googleLogin,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: OutlinedButton.icon(
                                icon: Image.asset(
                                  'assets/icons/github.png',
                                  width: 20,
                                  height: 20,
                                ),
                                label: const Text("Github登录"),
                                onPressed: () {
                                  _githubLogin();
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextButton(
                              onPressed: () {
                                _showLoginSheet(context);
                              },
                              child: Text(
                                "邮箱登录",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "没有账号？",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.goNamed('register');
                              },
                              child: Text(
                                "去注册",
                                style: TextStyle(
                                  decorationColor:
                                      Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLoginSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // 这里是关键设置
      builder: (BuildContext context) {
        // 为了进一步改善体验，你可以包裹内容在 SingleChildScrollView 中，并且使用 Padding 包裹 SingleChildScrollView，设置其底部内边距为 MediaQuery.of(context).viewInsets.bottom，这样可以确保内容不会被键盘遮挡。
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min, // 使内容大小适应
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/logos/logo.gif",
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        '邮箱登录',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const LoginEmail(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
