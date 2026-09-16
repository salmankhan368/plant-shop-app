import 'dart:async';

import 'package:demo_proj/core/exception/app_exception.dart';
import 'package:demo_proj/core/utils/enum/auth_status.dart';
import 'package:demo_proj/features/auth/repository/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends ChangeNotifier {
  final AuthRepository authRepository;
  AuthController(this.authRepository);
  User? get currentUser => FirebaseAuth.instance.currentUser;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _errorMessage;
  String? get error => _errorMessage;
  //resend countdown
  Timer? _timer;
  bool _canResend = true;
  bool get canResend => _canResend;
  int _countDown = 60;
  int get countDown => _countDown;

  String get currentUserEmail {
    return FirebaseAuth.instance.currentUser?.email ?? "";
  }

  //timer for resend email
  void sendResendTimer() async {
    _canResend = false;
    _countDown = 60;
    notifyListeners();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countDown > 0) {
        _countDown--;
        notifyListeners();
      } else {
        _timer?.cancel();
        _canResend = true;
        notifyListeners();
      }
    });
  }
  //login

  Future<void> login({required String email, required String password}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      authRepository.login(email: email, password: password);
    } on AppException catch (e) {
      _errorMessage = e.message;
    } catch (e) {
      _errorMessage = 'SomeThing went wrong';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //forget
  Future<void> forgetPassword({required String email}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      return await authRepository.forgetPassword(email: email);
    } on AppException catch (e) {
      _errorMessage = e.message;
    } catch (e) {
      _errorMessage = 'SomeThing went wrong';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //signUp
  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await authRepository.signup(name: name, email: email, password: password);
    } on AppException catch (e) {
      _errorMessage = e.message;
    } catch (e) {
      _errorMessage = "Something went wrong.";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //send email verification
  Future<void> sendEmailVerification() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      await authRepository.sendEmailVerification();
      sendResendTimer();
    } on AppException catch (e) {
      _errorMessage = e.message;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //reload user
  Future<void> reloadUser() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      return await authRepository.relaodUser();
    } on AppException catch (e) {
      _errorMessage = e.message;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //check email verification
  Future<bool> checkEmailVerified() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      return await authRepository.checkEmailVerification();
    } on AppException catch (e) {
      _errorMessage = e.message;
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //logout
  Future<void> logOut() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      await authRepository.logOut();
    } on AppException catch (e) {
      _errorMessage = e.message;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //session mangemnet
  Future<User?> getCurrent() async {
    try {
      return await authRepository.getCurrent();
    } on AppException catch (e) {
      _errorMessage = e.message;
      return null;
    }
  }

  //check userSessin
  Future<AuthStatus> checkUserSession() async {
    try {
      return await authRepository.checkUserSession();
    } on AppException catch (e) {
      _errorMessage = e.message;
      return AuthStatus.loggedOut;
    } catch (e) {
      _errorMessage = "Something went wrong.";
      return AuthStatus.loggedOut;
    }
  }

  //update profile
  Future<void> updateProfile({required String name, XFile? image}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      String? imageUrl;

      if (image != null) {
        imageUrl = await authRepository.uploadProfileImage(image: image);
      }

      await authRepository.updateProfile(name: name, imageUrl: imageUrl);
    } on AppException catch (e) {
      _errorMessage = e.message;
    } catch (e) {
      _errorMessage = 'Something went wrong';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //change password
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    _isLoading == true;
    _errorMessage = null;
    notifyListeners();
    try {
      await authRepository.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
    } on AppException catch (e) {
      _errorMessage = e.message;
    } catch (e) {
      _errorMessage = 'Something went wrong. Please try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
