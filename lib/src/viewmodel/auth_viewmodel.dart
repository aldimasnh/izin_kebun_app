import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:izin_kebun_app/helpers/sharedPreferences.dart';
import 'package:izin_kebun_app/src/model/auth_model.dart';

class AuthViewModel extends ChangeNotifier {
  bool isLoading = false;
  String errorMessage = '';
  int statusCode = 99;

  Future<void> onlineAuth(AuthModel user) async {
    SharedPreferencesManager prefsManager =
        await SharedPreferencesManager.getInstance();
    const url = 'https://mobilepro.srs-ssms.com/config/apk-login.php';

    statusCode = 99;
    errorMessage = '';
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(url),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      isLoading = false;
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        int success = jsonData['success'];
        statusCode = success;

        if (statusCode == 1) {
          await prefsManager.saveValue('userId', jsonData['user_id'] ?? '');
          await prefsManager.saveValue('email', jsonData['email'] ?? '');
          await prefsManager.saveValue('password', jsonData['password'] ?? '');
          await prefsManager.saveValue(
              'namaLengkap', jsonData['nama_lengkap'] ?? '');
          await prefsManager.saveValue(
              'departemen', jsonData['departemen'] ?? '');
          await prefsManager.saveValue('jabatan', jsonData['jabatan'] ?? '');
          await prefsManager.saveValue(
              'lokasiKerja', jsonData['lokasi_kerja'] ?? '');
          await prefsManager.saveValue('afdeling', jsonData['afdeling'] ?? '');
        }

        debugPrint('jsonData: $jsonData');
        debugPrint('success: $success');
        // Parse jsonData and handle success/error according to your API response
      } else {
        statusCode = 0;
        errorMessage =
            'Failed to authenticate. Status code: ${response.statusCode}';
      }
    } catch (e) {
      isLoading = false;
      errorMessage = 'Error occurred: $e';
    }

    notifyListeners();
  }
}
