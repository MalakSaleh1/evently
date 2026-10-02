import 'package:dots_indicator/dots_indicator.dart';
import 'package:evently/core/app_colors.dart';
import 'package:evently/core/app_provider/app_provider.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/modules/auth/login_screen.dart';
import 'package:evently/widgets/select_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {

  bool get _isLast => _currentPage == screenDetails.length - 1;

  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  PageController pageController=PageController();
  int _currentPage = 0;

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

  List<Map<String,dynamic>> screenDetails=[
    {
      "image":"assets/images/onboarding/hot-trending.png",
      "title":"Find Events That Inspire You",
      "desc":"Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you."
    },{
      "image":"assets/images/onboarding/being-creative.png",
      "title":"Effortless Event Planning",
      "desc":"Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests."
    },{
      "image":"assets/images/onboarding/being-creative-1.png",
      "title":"Connect with Friends & Share Moments",
      "desc":"Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories."
    }
  ];


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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ?_currentPage>=1? InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.primaryColorLight,
                        border: Border.all(
                          color: theme.dividerColor,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.shadow,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(8),
                      child:
                          Row(
                            children: [
                              SizedBox(width: 4,),
                              Icon(
                                Icons.arrow_back_ios,
                                size: 16,
                                color: provider.themeMode == ThemeMode.light
                                    ? AppColors.lightPrimaryColor
                                    : AppColors.white,
                              ),
                            ],
                          ),
                    ),
                  ):SizedBox(width: 38,),
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
                  ?_isLast?SizedBox(width:55,) :InkWell(
                    onTap: () {
                       pageController.jumpToPage(screenDetails.length-1);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.primaryColorLight,
                        border: Border.all(
                          color: theme.dividerColor,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.shadow,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 6),
                      child: Center(
                        child: Text("Skip",style: TextStyle(
                          fontWeight: FontWeight.w600,
                            color: provider.themeMode == ThemeMode.light
                                ? AppColors.lightPrimaryColor
                                : AppColors.white,
                          fontSize: 14
                        )),
                      )
                    ),
                  ),
                ],
              ),
              Container(
                height: 650,
                child: PageView.builder(
                  itemCount: screenDetails.length,
                  controller: pageController,
                  onPageChanged: (index){
                    setState(() => _currentPage = index);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            screenDetails[index]["image"],
                            height: MediaQuery.of(context).size.height/2.5,
                            color: theme.primaryColorDark,
                          ),
                        ),
                        Center(
                          child: DotsIndicator(
                            position: _currentPage.toDouble(),
                            onTap: (index) {
                              pageController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            },
                            dotsCount: screenDetails.length,
                            decorator: DotsDecorator(
          
                              activeColor: theme.primaryColor,
                              size: Size(8,8),
                              activeSize: Size(20,8),
                              activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(36),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16,),
                        Text(
                          screenDetails[index]["title"],
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 150,
                          child: Text(
                            screenDetails[index]["desc"],
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            _onNext();
                          },
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(9),
                              child: Text(
                                _isLast ? "Get Started" : "Next",
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
          
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}