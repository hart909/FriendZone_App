import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:friendszone_app/responsive/mobile_screen_layout.dart';
import 'package:friendszone_app/responsive/responsive_layout_screen.dart';
import 'package:friendszone_app/responsive/web_screen_layout.dart';
import 'package:friendszone_app/screens/login_screen.dart';
import 'package:friendszone_app/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDCJBbHbutURc6tfTLCHe6_HMyQiZxBHJc",
            appId: "1:174195883234:web:1aff6aaa8505c09eef32bb",
            messagingSenderId: "174195883234",
            projectId: "friendzone-ad189",
            storageBucket: "friendzone-ad189.appspot.com",
            ),
            );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FriendZone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      // home: const ResponsiveLayout(
      //   mobileScreenLayout: MobileScreenLayout(),
      //   webScreenLayout: WebScreenLayout(),
      // ),
      home: LoginScreen(),
    );
  }
}
