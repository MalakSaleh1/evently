

import 'package:evently/core/app_colors.dart';
import 'package:evently/modules/auth/maneger/auth_provider.dart';
import 'package:evently/modules/auth/register_screen.dart';
import 'package:evently/modules/auth/reset_password_screen.dart';
import 'package:evently/modules/auth/services/auth_service.dart';
import 'package:evently/widgets/custom_text_form.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';


import '../../core/app_provider/app_provider.dart';
import '../../l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordVisible=false;
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController=TextEditingController();
    TextEditingController passwordController=TextEditingController();
    var provider = Provider.of<AppProvider>(context);
    ThemeData theme = Theme.of(context);
    var locale = AppLocalizations.of(context)!;
    GlobalKey<FormState> _key =GlobalKey<FormState>();
    return ChangeNotifierProvider(
      create: (context)=>AuthProvider(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(18),
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Consumer<AuthProvider>(
                builder: (BuildContext context, AuthProvider _provider, Widget? child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Center(
                        child: Image.asset(
                          "assets/images/logo/evently.png",
                          width: 142,
                          color: theme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 24),

                      Text(
                        locale.loginToYourAccount,
                        style: TextStyle(
                          color: provider.themeMode == ThemeMode.light
                              ? theme.primaryColor
                              : AppColors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 24),
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
                      TextFormField(
                        obscureText: !isPasswordVisible,
                        validator: (value){
                          if(value==null || value.trim().isEmpty){
                            return "Enter your Password";
                          }
                          else if(value.length< 6){
                            return "Password should be more than 6 characters";
                          }
                        },
                        controller: passwordController,
                        decoration: InputDecoration(
                            hintText: locale.enterYourPassword,
                            prefixIcon: Icon(Iconsax.lock,color:provider.themeMode==ThemeMode.light? AppColors.lightTextFieldColor:AppColors.darkTextFieldColor,),
                            suffixIcon: InkWell(
                                onTap: (){
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                                child: isPasswordVisible?Icon(Iconsax.eye_slash,color:provider.themeMode==ThemeMode.light? AppColors.lightTextFieldColor:AppColors.darkTextFieldColor,):Icon(Iconsax.eye,color:provider.themeMode==ThemeMode.light? AppColors.lightTextFieldColor:AppColors.darkTextFieldColor,))
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ResetPasswordScreen()),
                              );
                            },
                            child: Text(
                              locale.forgetPassword,
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: theme.primaryColor,
                                decorationThickness: 2,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: theme.primaryColor,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 48),

                      ElevatedButton(
                        onPressed: () {
                          if(_key.currentState!.validate()){
                          _provider.signIn(email: emailController.text, password: passwordController.text, context: context);
                        }},
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child:_provider.isLoading? CircularProgressIndicator(): Text(
                              locale.login,
                              style: const TextStyle(color: AppColors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            locale.dontHaveAnAccount,
                            style: theme.textTheme.titleSmall,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) =>  RegisterScreen()),
                              );
                            },
                            child: Text(
                              locale.signup,
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: theme.primaryColor,
                                decorationThickness: 2,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: theme.primaryColor,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 24,),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color:provider.themeMode==ThemeMode.dark? theme.dividerColor:AppColors.darkGreyColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text("or",style: TextStyle(
                              color:provider.themeMode==ThemeMode.dark? theme.dividerColor:AppColors.darkGreyColor,
                            ),),
                          ),
                          Expanded(child: Divider(
                            color:provider.themeMode==ThemeMode.dark? theme.dividerColor:AppColors.darkGreyColor,
                          ))
                        ],
                      ),
                      const SizedBox(height: 16,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColorLight,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: theme.dividerColor,
                                
                            ),
                             
                          ),
                            
                        ),
                        onPressed: () {
                            _provider.signInWithGoogle( context: context);
                          },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child:_provider.isLoadingForGoogle? CircularProgressIndicator(): Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/logo/google.png",width: 24,),
                                SizedBox(width: 16,),
                                Text(
                                "Sign In With Google",
                                  style: theme.textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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