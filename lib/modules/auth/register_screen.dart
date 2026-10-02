import 'package:evently/core/app_colors.dart';
import 'package:evently/modules/auth/login_screen.dart';
import 'package:evently/modules/auth/services/auth_service.dart';
import 'package:evently/modules/layout/screens/home_screen/home_screen.dart';
import 'package:evently/widgets/custom_text_form.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';


import '../../core/app_provider/app_provider.dart';
import '../../l10n/app_localizations.dart';
import 'maneger/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
   RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController=TextEditingController();

   TextEditingController nameController=TextEditingController();

   TextEditingController passwordController=TextEditingController();

   TextEditingController rePasswordController=TextEditingController();

   bool isPasswordVisible=false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    ThemeData theme = Theme.of(context);
    var locale = AppLocalizations.of(context)!;
     GlobalKey<FormState> key =GlobalKey<FormState>();
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(18),
          child: SingleChildScrollView(
            child: Consumer<AuthProvider>(
              builder: (BuildContext context, _provider, Widget? child) {
                return Form(
                  key: key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Center(
                        child: Image.asset(
                          "assets/images/logo/evently.png",
                          width: 142,
                          color: theme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        locale.createYourAccount,
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
                              return "Enter your name";
                            }
                          },
                          controller: nameController,
                          decoration:InputDecoration(
                              hintText: locale.enterYourName,
                              prefixIcon: Icon(Iconsax.user,color:provider.themeMode==ThemeMode.light? AppColors.lightTextFieldColor:AppColors.darkTextFieldColor,)
                          )
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
                      const SizedBox(height: 24),
                      TextFormField(
                        obscureText: !isPasswordVisible,
                        validator: (value){
                          if(value!= passwordController.text){
                            return "Password not matched";
                          }
                        },
                        controller: rePasswordController,
                        decoration: InputDecoration(
                            hintText: locale.confirmYourPassword,
                            prefixIcon: Icon(Iconsax.lock,color:provider.themeMode==ThemeMode.light? AppColors.lightTextFieldColor:AppColors.darkTextFieldColor,),
                            suffixIcon:InkWell(
                                onTap: (){
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                                child: isPasswordVisible?Icon(Iconsax.eye_slash,color:provider.themeMode==ThemeMode.light? AppColors.lightTextFieldColor:AppColors.darkTextFieldColor,):Icon(Iconsax.eye,color:provider.themeMode==ThemeMode.light? AppColors.lightTextFieldColor:AppColors.darkTextFieldColor,))
                        ),
                      ),
                      const SizedBox(height: 48),
                      ElevatedButton(
                        onPressed: () {
                          if(key.currentState!.validate()){
                            _provider.createAccount(email: emailController.text, password: passwordController.text, name: nameController.text, context: context);

                          }

                        },
                        child: Center(
                          child:  Padding(
                            padding: const EdgeInsets.all(12),
                            child:_provider.isLoading?CircularProgressIndicator(): Text(
                              locale.signUpButton,
                              style: const TextStyle(color: AppColors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            locale.alreadyHaveAnAccount,
                            style: theme.textTheme.titleSmall,
                          ),
                          const SizedBox(width: 4),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginScreen()),
                              );
                            },
                            child: Text(
                              locale.login,
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
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}