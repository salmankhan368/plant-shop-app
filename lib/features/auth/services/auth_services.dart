import 'dart:io';

import 'package:demo_proj/core/exception/app_exception.dart';
import 'package:demo_proj/core/exception/firebase_exception.dart';
import 'package:demo_proj/core/utils/enum/auth_status.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

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
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.updateDisplayName(name);

      return userCredential;
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

  //edit profile
  Future<void> updateProfile({required String name, String? imageUrl}) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload();
      }
    } on FirebaseAuthException catch (e) {
      throw AppException(FirebaseExceptionHandler.getMessage(e));
    } catch (e) {
      throw const AppException("Something went wrong. Please try again.");
    }
  }

  //upload profile
  Future<String> uploadProfileImage({required XFile image}) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        throw const AppException('User not found.');
      }

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('${user.uid}.jpg');

      await storageRef.putFile(File(image.path));

      final imageUrl = await storageRef.getDownloadURL();

      return imageUrl;
    } on FirebaseException catch (e) {
      throw AppException(e.message ?? 'Image upload failed.');
    } catch (e) {
      if (e is AppException) rethrow;

      throw const AppException('Something went wrong. Please try again.');
    }
  }

  //change password
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw AppException('User not found');
      }
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      throw AppException(FirebaseExceptionHandler.getMessage(e));
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('Something went wrong. Please try again.');
    }
  }
}
