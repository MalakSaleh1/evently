import 'package:evently/core/app_colors.dart';
import 'package:evently/core/app_provider/app_provider.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/modules/auth/login_screen.dart';
import 'package:evently/modules/onboarding/screens/onboarding.dart';
import 'package:evently/widgets/select_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    ThemeData theme = Theme.of(context);
    var locale = AppLocalizations.of(context)!;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Hero(
                  tag: "logo",
                  child: Image.asset(
                    "assets/images/logo/evently.png",
                    width: 142,
                    color: theme.primaryColor,
                  ),
                ),
              ),
              Image.asset(
                "assets/images/logo/being-creative.png",
                color: theme.primaryColorDark,
              ),
              Text(
                locale.personalizeExperience,
                style: theme.textTheme.titleLarge,
              ),
              Text(
                locale.onboardingDescription,
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Text(
                    locale.language,
                    style: theme.textTheme.titleMedium,
                  ),
                  const Spacer(),
                  SelectBox(
                    title: "English",
                    isSelected: provider.locale == "en",
                    onTap: () {
                      provider.changeLanguage("en");
                    },
                  ),
                  const SizedBox(width: 8),
                  SelectBox(
                    title: "Arabic",
                    isSelected: provider.locale == "ar",
                    onTap: () {
                      provider.changeLanguage("ar");
                    },
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Text(
                    locale.theme,
                    style: theme.textTheme.titleMedium,
                  ),
                  const Spacer(),
                  SelectBox(
                    image: "assets/images/theme/sun.png",
                    isSelected: provider.themeMode == ThemeMode.light,
                    onTap: () {
                      provider.changeTheme(ThemeMode.light);
                    },
                  ),
                  const SizedBox(width: 8),
                  SelectBox(
                    image: "assets/images/theme/moon.png",
                    isSelected: provider.themeMode == ThemeMode.dark,
                    onTap: () {
                      provider.changeTheme(ThemeMode.dark);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Onboarding()));
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(9),
                    child: Text(
                      locale.letsStart,
                      style: theme.textTheme.bodyMedium,
                    ),
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