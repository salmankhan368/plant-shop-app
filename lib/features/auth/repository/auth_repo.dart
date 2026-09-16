import 'package:demo_proj/core/utils/enum/auth_status.dart';
import 'package:demo_proj/features/auth/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class AuthRepository {
  final AuthServices _authServices;
  AuthRepository(this._authServices);
  //login
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await _authServices.login(email: email, password: password);
  }

  //forget password
  Future<void> forgetPassword({required String email}) async {
    return await _authServices.forgetPassword(email: email);
  }

  //signup
  Future<UserCredential> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    return await _authServices.signUp(
      name: name,
      email: email,
      password: password,
    );
  }

  //send email verification
  Future<void> sendEmailVerification() async {
    return await _authServices.sendEmailVerification();
  }

  //reload user
  Future<void> relaodUser() async {
    await _authServices.reloadUser();
  }

  //check email verification
  Future<bool> checkEmailVerification() async {
    return await _authServices.checkEmailVerification();
  }

  //logout
  Future<void> logOut() async {
    await _authServices.logOut();
  }

  //session controller
  Future<User?> getCurrent() async {
    return _authServices.getCurrentUser();
  }

  //check user session
  Future<AuthStatus> checkUserSession() async {
    return _authServices.checkUserSession();
  }

  //update profile
  Future<void> updateProfile({required String name, String? imageUrl}) async {
    await _authServices.updateProfile(name: name, imageUrl: imageUrl);
  }

  //upload profile
  Future<String> uploadProfileImage({required XFile image}) async {
    return await _authServices.uploadProfileImage(image: image);
  }

  //change password
  Future<void> changePassword({
    required currentPassword,
    required newPassword,
  }) async {
    await _authServices.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }
}
