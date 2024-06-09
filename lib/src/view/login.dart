import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:izin_kebun_app/helpers/custom_textfield.dart';
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
  late SharedPreferencesManager _prefsManager;

  final NavigationService _navigationService = NavigationService.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  var _emailUser = '';
  var _passUser = '';

  @override
  void initState() {
    super.initState();
    _initializePrefsManager();
  }

  Future<void> _initializePrefsManager() async {
    _prefsManager = await SharedPreferencesManager.getInstance();
    setState(() {
      _emailUser = _prefsManager.loadValue('email', false);
      _passUser = _prefsManager.loadValue('password', false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.transparent,
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
                          'Login here',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF16A34A),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 100),
                        child: Center(
                          child: AutoSizeText(
                            "Welcome back you've been missed!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
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
              Container(
                height: screenHeight * 0.6,
                // decoration: const BoxDecoration(
                //   image: DecorationImage(
                //     image: AssetImage('assets/images/logo_cbi.png'),
                //     fit: BoxFit.cover,
                //   ),
                // ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.transparent,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: CustomTextField(
                          controller: _emailController,
                          name: "Email",
                          prefixIcon: Icons.email_outlined,
                          inputType: TextInputType.emailAddress,
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: CustomTextField(
                          controller: _passController,
                          name: "Password",
                          prefixIcon: Icons.lock_outline,
                          inputType: TextInputType.text,
                          obscureText: true,
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                debugPrint("Forgot your password?");
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
                                'Forgot your password?',
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
                            left: 30, right: 30, top: 30, bottom: 40),
                        child: _emailUser.isNotEmpty && _passUser.isNotEmpty
                            ? Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 30),
                                        child: SizedBox(
                                          height: 50,
                                          child: TextButton(
                                            onPressed: () {},
                                            style: ButtonStyle(
                                              shape: WidgetStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                            ),
                                            child: const Text(
                                              'Verification',
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
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30, right: 10),
                                        child: SizedBox(
                                          height: 50,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              debugPrint(
                                                  'email: ${_emailController.text} && pw: ${_passController.text}');
                                              if (_emailController
                                                      .text.isEmpty ||
                                                  _passController
                                                      .text.isEmpty) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                      content: Text(
                                                          'The Email / Password field is empty')),
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
                                                  viewModel.onlineAuth(
                                                      AuthModel(
                                                          email:
                                                              _emailController
                                                                  .text,
                                                          password:
                                                              _passController
                                                                  .text));
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
                                  ],
                                ),
                              )
                            : SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    debugPrint(
                                        'email: ${_emailController.text} && pw: ${_passController.text}');
                                    if (_emailController.text.isEmpty ||
                                        _passController.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'The Email / Password field is empty')),
                                      );
                                    } else {
                                      if (_emailUser.isNotEmpty &&
                                          _passUser.isNotEmpty) {
                                        Map<String, dynamic> dataPref = {
                                          'email': _emailUser,
                                          'password': _passUser,
                                        };

                                        viewModel.offlineAuth(
                                            AuthModel(
                                                email: _emailController.text,
                                                password: _passController.text),
                                            dataPref);
                                      } else {
                                        viewModel.onlineAuth(AuthModel(
                                            email: _emailController.text,
                                            password: _passController.text));
                                      }
                                    }
                                  },
                                  style: ButtonStyle(
                                    shape: WidgetStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    backgroundColor: WidgetStateProperty.all(
                                        const Color(0xFF16A34A)),
                                    elevation: WidgetStateProperty.all(15),
                                    shadowColor: WidgetStateProperty.all(
                                        const Color(0xFF16A34A)
                                            .withOpacity(0.5)),
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
                      TextButton(
                        onPressed: () {
                          debugPrint("create new account");
                        },
                        style: ButtonStyle(
                          overlayColor:
                              WidgetStateProperty.all(Colors.transparent),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Create new account',
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
          );
        },
      ),
    );
  }
}
