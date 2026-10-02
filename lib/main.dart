import 'package:evently/core/app_provider/app_provider.dart';
import 'package:evently/core/theme.dart';
import 'package:evently/modules/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'firebase_options.dart';
import 'l10n/app_localizations.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await GoogleSignIn.instance.initialize(
      serverClientId:"992169757551-vv0blgesucqkqk1gqd9v8f17bp4mud04.apps.googleusercontent.com"
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context)=>AppProvider(),
      builder: (context,child){
        var provider=Provider.of<AppProvider>(context);
        return MaterialApp(
          locale:Locale(provider.locale),
          localizationsDelegates: [
            AppLocalizations.delegate, // Add this line
            ...GlobalMaterialLocalizations.delegates,
          ],
          supportedLocales: [
            Locale('en'),
            Locale('ar'),
          ],
          themeMode: provider.themeMode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: const SplashScreen(),
        );
      },
    );
  }
}

