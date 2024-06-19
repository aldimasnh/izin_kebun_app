import 'package:flutter/material.dart';
import 'package:izin_kebun_app/helpers/navigator.dart';
import 'package:lottie/lottie.dart';

final NavigationService _navigationService = NavigationService.instance;

class CustomDialogWidget extends StatefulWidget {
  final bool confirmation;
  final String message;
  final Function function;

  const CustomDialogWidget({
    super.key,
    this.confirmation = false,
    this.message = 'Fitur dalam pengembangan',
    this.function = defaultFunction,
  });

  static void defaultFunction() {}

  @override
  // ignore: library_private_types_in_public_api
  _CustomDialogWidgetState createState() => _CustomDialogWidgetState();
}

class _CustomDialogWidgetState extends State<CustomDialogWidget> {
  @override
  void initState() {
    super.initState();
    if (!widget.confirmation) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          _navigationService.goBack();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          CardDialog(
            confirmation: widget.confirmation,
            message: widget.message,
            function: widget.function,
          ),
        ],
      ),
    );
  }
}

class CardDialog extends StatelessWidget {
  final bool confirmation;
  final String message;
  final Function function;

  const CardDialog({
    super.key,
    required this.confirmation,
    required this.message,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Colors.transparent,
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: const Color(0xFF047857),
                  width: 2.5,
                ),
              ),
              child: Lottie.asset('assets/animations/warning.json', width: 100),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: const Text(
              'Peringatan',
              style: TextStyle(
                fontSize: 25,
                color: Color(0xFF475556),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Color(0xFF475556),
              ),
            ),
          ),
          if (confirmation)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 55,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                            ),
                          ),
                        ),
                        backgroundColor:
                            WidgetStateProperty.all(const Color(0xFFcbd5e1)),
                      ),
                      onPressed: () {
                        _navigationService.goBack();
                      },
                      child: const Text(
                        'Batal',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 55,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                        ),
                        backgroundColor:
                            WidgetStateProperty.all(const Color(0xFF047857)),
                      ),
                      onPressed: () => function(),
                      child: const Text(
                        'Ya',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          else
            const SizedBox(),
        ],
      ),
    );
  }
}
