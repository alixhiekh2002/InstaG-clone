import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:i_clone/provider/user_provider.dart';
import 'package:i_clone/responsive/mobile_screen_layout.dart';
import 'package:i_clone/responsive/responsive_layout_screen.dart';
import 'package:i_clone/responsive/web_screen_layout.dart';
import 'package:i_clone/screens/loginScreen.dart';
import 'package:i_clone/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAIHrXVxVPVTe45y3zwxr8OeNbJf7H7mfk",
        appId: "1:774887741154:web:51cf0acce441d32850b0bb",
        messagingSenderId: "774887741154",
        projectId: "instag-clne",
        storageBucket: "instag-clne.appspot.com",
      ),
    );
  } else if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAaEly38RJj3npNQKYYyWNK_7WgMTciUv0",
            appId: "1:774887741154:ios:ddc17b79f448a17f50b0bb",
            messagingSenderId: "774887741154",
            projectId: "instag-clne"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Instagram Clone",
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
