import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class AuthService {


  static Future<User?> createAccount({required String email,required String password,required String name})async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      credential.user?.updateProfile(displayName: name);
      credential.user?.updateDisplayName(name);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw'The account already exists for that email.';
      }else{
        throw e.message??"";
      }
    } catch (e) {
      rethrow;
    }
  }


  static Future<User?> signIn({required String email,required String password,})async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      throw "Invalid email or password";
    }
  }


  static Future<void>  resetPassword({required String email})async{
    try {
     await FirebaseAuth.instance.sendPasswordResetEmail(
          email: email,
      );
    } on FirebaseAuthException catch (e) {
      throw "Invalid email";
    }
  }

  static Future<User> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn.instance.authenticate();

      final idToken = googleUser.authentication.idToken;
      if (idToken == null) {
        throw Exception('Failed to get Google ID token');
      }

      final credential = GoogleAuthProvider.credential(idToken: idToken);
      final userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      return userCredential.user!;
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) ;
      rethrow;
    } on FirebaseAuthException {
      rethrow;
    }
  }
  }



