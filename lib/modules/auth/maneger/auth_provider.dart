import 'package:evently/modules/auth/services/auth_service.dart';
import 'package:evently/modules/layout/screens/home_screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthProvider extends ChangeNotifier{

   bool isLoading=false;
   bool isLoadingForGoogle=false;

   late User user ;


   Future<void> createAccount({
     required String email,
    required String password,
    required String name,
   required BuildContext context})async {
    isLoading=true;
    notifyListeners();
    try {
     user=(await AuthService.createAccount(email: email, password: password, name: name))!;
     ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
           elevation: 0,
             behavior: SnackBarBehavior.floating,
             backgroundColor: Colors.green,
             content: Text("Welcome $name")));
    }catch(e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(

            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            content: Text(e.toString())));
    };
     isLoading=false;
     notifyListeners();

}


   Future<void> signIn({
     required String email,
     required String password,
     required BuildContext context})async {
     isLoading=true;
     notifyListeners();
     try {
       user=(await AuthService.signIn(email: email, password: password,))!;
       ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
               elevation: 0,
               behavior: SnackBarBehavior.floating,
               backgroundColor: Colors.green,
               content: Text("Welcome Back ${user.displayName}")));
     }catch(e) {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(

           elevation: 0,
           behavior: SnackBarBehavior.floating,
           backgroundColor: Colors.red,
           content: Text(e.toString())));
     };
     isLoading=false;
     notifyListeners();

   }


   Future<void> resetPassword({
     required String email,
     required BuildContext context})async {
     isLoading=true;
     notifyListeners();
     try {
       await AuthService.resetPassword(email: email,);
       ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
               elevation: 0,
               behavior: SnackBarBehavior.floating,
               backgroundColor: Colors.green,
               content: Text("Check Your Email")));
     }catch(e) {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(

           elevation: 0,
           behavior: SnackBarBehavior.floating,
           backgroundColor: Colors.red,
           content: Text(e.toString())));
     };
     isLoading=false;
     notifyListeners();

   }






   Future<void> signInWithGoogle({
     required BuildContext context})async {
     isLoadingForGoogle=true;
     notifyListeners();
     try {
       user=(await AuthService.signInWithGoogle())!;
       ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
               elevation: 0,
               behavior: SnackBarBehavior.floating,
               backgroundColor: Colors.green,
               content: Text("Welcome ${user.displayName}")));
       Future.delayed(Duration(milliseconds: 300,),(){
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
       })  ;
     }catch(e) {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
           elevation: 0,
           behavior: SnackBarBehavior.floating,
           backgroundColor: Colors.red,
           content: Text(e.toString())));
     };
     isLoadingForGoogle=false;
     notifyListeners();

   }
}