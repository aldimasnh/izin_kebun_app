import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:izin_kebun_app/helpers/connectivity_service.dart';
import 'package:izin_kebun_app/helpers/custom_alert_dialog.dart';
import 'package:izin_kebun_app/helpers/custom_textfield.dart';
import 'package:izin_kebun_app/helpers/helpers.dart';
import 'package:izin_kebun_app/helpers/sharedPreferences.dart';
import 'package:izin_kebun_app/src/model/auth_model.dart';
import 'package:izin_kebun_app/src/viewmodel/auth_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:izin_kebun_app/helpers/navigator.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isConnected = false;
  String _scanBarcode = '';
  late SharedPreferencesManager _prefsManager;

  final ConnectivityService _connectivityService = ConnectivityService();
  final NavigationService _navigationService = NavigationService.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  var _emailUser = '';
  var _passUser = '';

  @override
  void initState() {
    super.initState();
    _initializePrefsManager();
    _checkInitialConnectivity();
    _listenToConnectivityChanges();
  }

  Future<void> _checkInitialConnectivity() async {
    bool isConnected = await _connectivityService.checkConnectivity();
    setState(() {
      _isConnected = isConnected;
    });
  }

  void _listenToConnectivityChanges() {
    _connectivityService.connectivityStream.listen((isConnected) {
      setState(() {
        _isConnected = isConnected;
      });
    });
  }

  Future<void> _startScanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      debugPrint('Failed to get platform version/scan QR.');
      barcodeScanRes = '';
    }
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;

      if (_scanBarcode.isNotEmpty) {
        String decryptedData = Helpers.aesDecrypt(_scanBarcode, 'CBI@2024');
        if (decryptedData.isNotEmpty) {
          _navigationService.navigate('/verification', arguments: {
            'dataQr': decryptedData,
          });
        } else {
          debugPrint('Failed to decrypt data.');
        }
      }
    });
  }

  Future<void> _initializePrefsManager() async {
    _prefsManager = await SharedPreferencesManager.getInstance();
    setState(() {
      _emailUser = _prefsManager.loadValue('email', '');
      _passUser = _prefsManager.loadValue('password', '');
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        SystemNavigator.pop();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: null,
        body: Consumer<AuthViewModel>(
          builder: (context, viewModel, child) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (viewModel.isLoading) {
                _navigationService.showLoader();
              } else {
                _navigationService.hideLoader();
                if (viewModel.statusCode == 1) {
                  _navigationService.navigate('/webview');
                }
              }
            });

            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.4,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/logo_cbi.png',
                              width: 120,
                              height: 120,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 25),
                              child: const AutoSizeText(
                                'Masuk',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF16A34A),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 50),
                              child: Center(
                                child: AutoSizeText(
                                  "Selamat datang, silakan isikan email dan password!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.6,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              child: CustomTextField(
                                controller: _emailController,
                                name: "Email",
                                prefixIcon: Icons.email_outlined,
                                inputType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: CustomTextField(
                                controller: _passController,
                                name: "Password",
                                prefixIcon: Icons.lock_outline,
                                inputType: TextInputType.text,
                                obscureText: true,
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  const Spacer(),
                                  TextButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            const CustomDialogWidget(),
                                      );
                                    },
                                    style: ButtonStyle(
                                      overlayColor: WidgetStateProperty.all(
                                          Colors.transparent),
                                      shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                    child: const Text(
                                      'Lupa kata sandi?',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF16A34A),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 30, right: 30, top: 20, bottom: 40),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: 50,
                                          child: OutlinedButton(
                                            style: ButtonStyle(
                                              shape: WidgetStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                              side: WidgetStateProperty.all(
                                                  const BorderSide(
                                                      color: Colors.black,
                                                      width: 1.5)),
                                            ),
                                            onPressed: () => _startScanQR(),
                                            child: const Text(
                                              'Verifikasi',
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: SizedBox(
                                          height: 50,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if (_emailController
                                                      .text.isEmpty ||
                                                  _passController
                                                      .text.isEmpty) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                      content: Text(
                                                          'Email / Password tidak boleh kosong.')),
                                                );
                                              } else {
                                                if (_emailUser.isNotEmpty &&
                                                    _passUser.isNotEmpty) {
                                                  Map<String, dynamic>
                                                      dataPref = {
                                                    'email': _emailUser,
                                                    'password': _passUser,
                                                  };

                                                  viewModel.offlineAuth(
                                                      AuthModel(
                                                          email:
                                                              _emailController
                                                                  .text,
                                                          password:
                                                              _passController
                                                                  .text),
                                                      dataPref);
                                                } else {
                                                  if (_isConnected) {
                                                    viewModel.onlineAuth(
                                                        AuthModel(
                                                            email:
                                                                _emailController
                                                                    .text,
                                                            password:
                                                                _passController
                                                                    .text));
                                                  } else {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          const CustomDialogWidget(
                                                        message:
                                                            'Mohon periksa koneksi internet',
                                                      ),
                                                    );
                                                  }
                                                }
                                              }
                                            },
                                            style: ButtonStyle(
                                              shape: WidgetStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                              backgroundColor:
                                                  WidgetStateProperty.all(
                                                      const Color(0xFF16A34A)),
                                              elevation:
                                                  WidgetStateProperty.all(15),
                                              shadowColor:
                                                  WidgetStateProperty.all(
                                                      const Color(0xFF16A34A)
                                                          .withOpacity(0.5)),
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
                                    ],
                                  ),
                                )),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      const CustomDialogWidget(),
                                );
                              },
                              style: ButtonStyle(
                                overlayColor:
                                    WidgetStateProperty.all(Colors.transparent),
                                shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Buat akun baru',
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
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
