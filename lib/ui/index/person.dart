import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:one_chatgpt_flutter/common/log.dart';
import 'package:one_chatgpt_flutter/state/auth.dart';
import 'package:one_chatgpt_flutter/widgets/network_image_with_loading.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Person extends StatefulWidget {
  const Person({super.key});

  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
  final supabase = Supabase.instance.client;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // ClipOval(
                //   child: NetworkImageWithLoading(
                //     imageUrl:
                //         'https://dummyimage.com/400x400/f213f2/101aad.png&text=a',
                //     width: 80,
                //     height: 80,
                //   ),
                // ),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://dummyimage.com/400x400/f213f2/101aad.png&text=a'),
                  radius: 40,
                  backgroundColor: Theme.of(context).colorScheme.secondaryFixed,
                  // child: const Text(
                  //   '点击上传',
                  //   overflow: TextOverflow.ellipsis,
                  //   style: TextStyle(fontSize: 12),
                  // ),
                ),
                FilledButton.icon(
                  label: const Text("修改"),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "zhang heng (山水有神怪)",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "laohu9711@gmail.com",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: Card.filled(
                    margin: EdgeInsets.zero,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '总Tokens',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              Icon(
                                color: Theme.of(context).colorScheme.secondary,
                                Icons.refresh,
                                size: 20,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: TweenAnimationBuilder<int>(
                              tween: IntTween(begin: 0, end: 1000),
                              duration: Duration(seconds: 1),
                              builder: (context, value, child) {
                                return Text(
                                  '$value', // 动画中逐渐显示数字
                                  style: TextStyle(
                                    fontSize: 26,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontFamily: GoogleFonts.anton().fontFamily,
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Card.filled(
                    margin: EdgeInsets.zero,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '剩余Tokens',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              Icon(
                                color: Theme.of(context).colorScheme.secondary,
                                Icons.refresh,
                                size: 20,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: TweenAnimationBuilder<int>(
                              tween: IntTween(begin: 0, end: 998),
                              duration: Duration(seconds: 1),
                              builder: (context, value, child) {
                                return Text(
                                  '$value', // 动画中逐渐显示数字
                                  style: TextStyle(
                                    fontSize: 26,
                                    color: Theme.of(context).colorScheme.error,
                                    fontFamily: GoogleFonts.anton().fontFamily,
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
