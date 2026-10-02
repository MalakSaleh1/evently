import 'package:dots_indicator/dots_indicator.dart';
import 'package:evently/core/app_colors.dart';
import 'package:evently/core/app_provider/app_provider.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/modules/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  static const int _pagesCount = 3;

  final PageController pageController = PageController();
  int _currentPage = 0;

  bool get _isLast => _currentPage == _pagesCount - 1;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  List<Map<String, String>> _getScreenDetails(AppLocalizations locale) => [
    {
      "image": "assets/images/onboarding/hot-trending.png",
      "title": locale.onboardingTitle1,
      "desc": locale.onboardingDesc1,
    },
    {
      "image": "assets/images/onboarding/being-creative.png",
      "title": locale.onboardingTitle2,
      "desc": locale.onboardingDesc2,
    },
    {
      "image": "assets/images/onboarding/being-creative-1.png",
      "title": locale.onboardingTitle3,
      "desc": locale.onboardingDesc3,
    },
  ];

  void _onNext() {
    if (_isLast) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void _onBack() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    ThemeData theme = Theme.of(context);
    var locale = AppLocalizations.of(context)!;
    final screenDetails = _getScreenDetails(locale);
    final screenHeight = MediaQuery.of(context).size.height;

    final Color accentColor = provider.themeMode == ThemeMode.light
        ? AppColors.lightPrimaryColor
        : AppColors.white;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _currentPage >= 1
                      ? InkWell(
                    onTap: _onBack,
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.primaryColorLight,
                        border: Border.all(color: theme.dividerColor),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(color: AppColors.shadow),
                        ],
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_back_ios,
                            size: 16,
                            color: accentColor,
                          ),
                        ],
                      ),
                    ),
                  )
                      : const SizedBox(width: 38),
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
                  _isLast
                      ? const SizedBox(width: 55)
                      : InkWell(
                    onTap: () {
                      pageController.jumpToPage(_pagesCount - 1);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.primaryColorLight,
                        border: Border.all(color: theme.dividerColor),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(color: AppColors.shadow),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      child: Center(
                        child: Text(
                          locale.skip,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: accentColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.78,
                child: PageView.builder(
                  itemCount: _pagesCount,
                  controller: pageController,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            screenDetails[index]["image"]!,
                            height: screenHeight / 2.5,
                            color: theme.primaryColorDark,
                          ),
                        ),
                        Center(
                          child: DotsIndicator(
                            position: _currentPage.toDouble(),
                            onTap: (i) {
                              pageController.animateToPage(
                                i,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            },
                            dotsCount: _pagesCount,
                            decorator: DotsDecorator(
                              activeColor: theme.primaryColor,
                              size: const Size(8, 8),
                              activeSize: const Size(20, 8),
                              activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(36),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          screenDetails[index]["title"]!,
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Text(
                              screenDetails[index]["desc"]!,
                              style: theme.textTheme.bodySmall,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _onNext,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(9),
                              child: Text(
                                _isLast ? locale.getStarted : locale.next,
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}