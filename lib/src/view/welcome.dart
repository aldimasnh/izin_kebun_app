import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:izin_kebun_app/src/view/login.dart';
import 'package:lottie/lottie.dart';
import 'package:izin_kebun_app/helpers/navigator.dart';

class Welcome extends StatelessWidget {
  final NavigationService _navigationService = NavigationService.instance;
  Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: null,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Adjust the height based on the screen height
          Container(
            color: Colors.transparent,
            height: screenHeight * 0.5,
            child: Center(
              child: Lottie.asset('assets/animations/welcome_vector.json'),
            ),
          ),
          Container(
            color: Colors.transparent,
            height: screenHeight * 0.3,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AutoSizeText(
                    'Ajukan Permohonan',
                    style: TextStyle(
                      fontSize: 35, // 10% of screen width
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF16A34A),
                    ),
                    maxLines: 1,
                  ),
                  const AutoSizeText(
                    'Suratmu Disini',
                    style: TextStyle(
                      fontSize: 35, // 10% of
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF16A34A),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 40.0, bottom: 0),
                    child: const AutoSizeText(
                      'Dapatkan, verifikasi dan lihat riwayat pengajuanmu',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF475556),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5, bottom: 0),
                    child: const AutoSizeText(
                      'dimanapun dan kapanpun',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF475556),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.transparent,
            height: screenHeight * 0.2,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, right: 10),
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            _navigationService.showLoader();
                            Future.delayed(const Duration(seconds: 1), () {
                              _navigationService.navigate(Login());
                            });
                          },
                          style: ButtonStyle(
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            backgroundColor: WidgetStateProperty.all(
                                const Color(0xFF16A34A)),
                            elevation: WidgetStateProperty.all(15),
                            shadowColor: WidgetStateProperty.all(
                                const Color(0xFF16A34A).withOpacity(0.5)),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 30),
                      child: SizedBox(
                        height: 50,
                        child: TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
