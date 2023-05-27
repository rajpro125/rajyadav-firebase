import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:vivatech/repository/exceptions/signup_failaure.dart';
import 'package:vivatech/screens/login.dart';

import '../../main.dart';
import '../../screens/home_page.dart';

class AuthRepository extends GetxController {
  static AuthRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setIntialScreen);
  }

  _setIntialScreen(User? user) {
    user == null
        ? Get.offAll(() => const LoginScreen())
        : Get.offAll(() => const HomePage());
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => const HomePage())
          : Get.to(() => const LoginScreen());
      Get.snackbar('SignUp', 'User Register Successfully',
          snackPosition: SnackPosition.BOTTOM);
    } on FirebaseAuthException catch (e) {
      final ex = SignUpFailure.code(e.code);
      Get.snackbar('Signup', ex.message, snackPosition: SnackPosition.BOTTOM);
      log('Firebase exception-${ex.message}');
      throw ex;
    } catch (_) {
      const ex = SignUpFailure();
      Get.snackbar('Signup', ex.message, snackPosition: SnackPosition.BOTTOM);
      log('Exception - ${ex.message}');
      throw ex;
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => const HomePage())
          : Get.to(() => const LoginScreen());
      Get.snackbar('SignIn', 'Welcome in homepage',
          snackPosition: SnackPosition.BOTTOM);
    } on FirebaseAuthException catch (e) {
      final ex = SignUpFailure.code(e.code);
      Get.snackbar('SignIn', ex.message, snackPosition: SnackPosition.BOTTOM);
      log('Firebase exception-${ex.message}');
      throw ex;
    } catch (_) {
      const ex = SignUpFailure();
      Get.snackbar('SignIn', ex.message, snackPosition: SnackPosition.BOTTOM);
      log('Exception - ${ex.message}');
      throw ex;
    }
  }

  Future<void> logout() async => await _auth.signOut();
  void showNotification(String msg) {
    flutterLocalNotificationsPlugin.show(
        0,
        "Welcome",
        msg,
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }
}
