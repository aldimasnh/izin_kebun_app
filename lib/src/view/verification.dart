import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:izin_kebun_app/helpers/navigator.dart';

class Verification extends StatelessWidget {
  final NavigationService _navigationService = NavigationService.instance;
  Verification({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final Map<String, dynamic> dataQrText = jsonDecode(args?['dataQr'] ?? '{}');

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        _navigationService.showLoader();
        Future.delayed(const Duration(milliseconds: 500), () {
          _navigationService.hideLoader();
          _navigationService.navigate('/login');
        });
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Surat Izin Keluar Kebun',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xFF047857),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            color: Colors.white,
            onPressed: () {
              _navigationService.showLoader();
              Future.delayed(const Duration(milliseconds: 500), () {
                _navigationService.hideLoader();
                _navigationService.navigate('/login');
              });
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      'Nama Karyawan',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Colors.black, width: 1.0), // Underline effect
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      dataQrText.isNotEmpty && dataQrText.containsKey("0")
                          ? dataQrText['0']
                          : "-",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      'Unit / Sub. Unit',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Colors.black, width: 1.0), // Underline effect
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      dataQrText.isNotEmpty && dataQrText.containsKey("10")
                          ? dataQrText['10']
                          : "-",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      'Jabatan',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Colors.black, width: 1.0), // Underline effect
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      dataQrText.isNotEmpty && dataQrText.containsKey("9")
                          ? dataQrText['9']
                          : "-",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      'Tujuan',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Colors.black, width: 1.0), // Underline effect
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      dataQrText.isNotEmpty && dataQrText.containsKey("5")
                          ? dataQrText['5']
                          : "-",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      'Keperluan',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: AutoSizeText(
                        dataQrText.isNotEmpty && dataQrText.containsKey("6")
                            ? dataQrText['6']
                            : "-",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        maxLines: 4,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: AutoSizeText(
                              'Tanggal Keluar',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: AutoSizeText(
                              'Tanggal Kembali',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                dataQrText.isNotEmpty &&
                                        dataQrText.containsKey("1")
                                    ? dataQrText['1']
                                    : "-",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                dataQrText.isNotEmpty &&
                                        dataQrText.containsKey("2")
                                    ? dataQrText['2']
                                    : "-",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: AutoSizeText(
                              'Jenis Kendaraan',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: AutoSizeText(
                              'Plat Nomor',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                dataQrText.isNotEmpty &&
                                        dataQrText.containsKey("3")
                                    ? dataQrText['3']
                                    : "-",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                dataQrText.isNotEmpty &&
                                        dataQrText.containsKey("4")
                                    ? dataQrText['4']
                                    : "-",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      'Approved By / Digital Signed By :',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Colors.black, width: 1.0), // Underline effect
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      dataQrText.isNotEmpty && dataQrText.containsKey("7")
                          ? 'Atasan 1 - ${dataQrText['7']}'
                          : "-",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 5, bottom: 50),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Colors.black, width: 1.0), // Underline effect
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      dataQrText.isNotEmpty && dataQrText.containsKey("8")
                          ? 'Atasan 2 - ${dataQrText['8']}'
                          : "-",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
