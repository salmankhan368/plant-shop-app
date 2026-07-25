import 'package:demo_proj/core/exception/app_exception.dart';
import 'package:demo_proj/core/exception/firebase_exception.dart';
import 'package:demo_proj/core/utils/enum/auth_status.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign in
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AppException(FirebaseExceptionHandler.getMessage(e));
    } catch (e) {
      throw const AppException("Something went wrong. Please try again.");
    }
  }

  //forget passwod
  Future<void> forgetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AppException(FirebaseExceptionHandler.getMessage(e));
    } catch (e) {
      throw const AppException("Something went wrong. Please try again.");
    }
  }

  //signup
  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AppException(FirebaseExceptionHandler.getMessage(e));
    } catch (e) {
      throw const AppException("Something went wrong. Please try again.");
    }
  }

  //email verification
  Future<void> sendEmailVerification() async {
    try {
      final user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
    } on FirebaseAuthException catch (e) {
      throw AppException(FirebaseExceptionHandler.getMessage(e));
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  //reload user
  Future<void> reloadUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      return await user.reload();
    }
  }

  //check email verification email verification
  Future<bool> checkEmailVerification() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return false;
      }
      await user.reload();
      return _auth.currentUser!.emailVerified;
    } on FirebaseAuthException catch (e) {
      throw AppException(FirebaseExceptionHandler.getMessage(e));
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  //logOut
  Future<void> logOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw AppException(FirebaseExceptionHandler.getMessage(e));
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  //sessionMangemnt
  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  //check sesion
  Future<AuthStatus> checkUserSession() async {
    final user = _auth.currentUser;
    if (user == null) {
      return AuthStatus.loggedOut;
    } else {
      await user.reload();
      return _auth.currentUser!.emailVerified
          ? AuthStatus.authenticated
          : AuthStatus.emailNotVerfied;
    }
  }
}
