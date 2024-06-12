import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:izin_kebun_app/helpers/custom_alert_dialog.dart';
import 'package:lottie/lottie.dart';
import 'package:izin_kebun_app/helpers/navigator.dart';

class Welcome extends StatelessWidget {
  final NavigationService _navigationService = NavigationService.instance;
  Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: screenHeight * 0.5,
                child: Center(
                  child: Lottie.asset('assets/animations/welcome_vector.json'),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.3,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AutoSizeText(
                        'Ajukan Permohonan',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF047857),
                        ),
                        maxLines: 1,
                      ),
                      const AutoSizeText(
                        'Suratmu Disini',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF047857),
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
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: screenHeight * 0.2,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              _navigationService.showLoader();
                              Future.delayed(const Duration(seconds: 1), () {
                                _navigationService.hideLoader();
                                _navigationService.navigate('/login');
                              });
                            },
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              backgroundColor: WidgetStateProperty.all(
                                  const Color(0xFF047857)),
                              elevation: WidgetStateProperty.all(15),
                              shadowColor: WidgetStateProperty.all(
                                  const Color(0xFF047857).withOpacity(0.5)),
                            ),
                            child: const Text(
                              'Masuk',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: OutlinedButton(
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              side: WidgetStateProperty.all(const BorderSide(
                                  color: Colors.black, width: 1.5)),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    const CustomDialogWidget(),
                              );
                            },
                            child: const Text(
                              'Daftar',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
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
        ),
      ),
    );
  }
}
