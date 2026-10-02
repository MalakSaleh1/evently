import 'package:evently/modules/auth/maneger/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../core/app_provider/app_provider.dart';
import '../../l10n/app_localizations.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    ThemeData theme = Theme.of(context);
    var locale = AppLocalizations.of(context)!;
    GlobalKey<FormState> _key =GlobalKey<FormState>();
    TextEditingController emailController=TextEditingController();

    return ChangeNotifierProvider(
      create: (context)=> AuthProvider(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Consumer<AuthProvider>(
                builder: (BuildContext context, AuthProvider _provider , Widget? child) {
                  return Form(
                    key: _key,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
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
                                child: Row(
                                  children: [
                                    const SizedBox(width: 4),
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
                            ),
                            Text(
                              locale.forgetPassword,
                              style: theme.textTheme.titleMedium,
                            ),
                            const SizedBox(width: 30),
                          ],
                        ),
                        const SizedBox(height: 35),
                        Image.asset(
                          "assets/images/logo/change-setting.png",
                          color: theme.primaryColorDark,
                        ),
                        const SizedBox(height: 40),
                        TextFormField(
                            validator: (value){
                              if(value==null || value.trim().isEmpty){
                                return "Enter your email";
                              }
                              else if(! RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)){
                                return "Enter valid email";
                              }
                            },
                            controller: emailController,
                            decoration:InputDecoration(
                                hintText: locale.enterYourEmail,
                                prefixIcon: Icon(Iconsax.sms,color:provider.themeMode==ThemeMode.light? AppColors.lightTextFieldColor:AppColors.darkTextFieldColor,)
                            )
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            if(_key.currentState!.validate()){
                            _provider.resetPassword(email: emailController.text, context: context);
                            }
                          },
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: _provider.isLoading?CircularProgressIndicator(): Text(
                                locale.resetPasswordButton,
                                style: const TextStyle(
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },

              ),
            ),
          ),
        ),
      ),
    );
  }
}