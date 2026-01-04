import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zeggo_cus/constants/app_colors.dart';
import 'package:zeggo_cus/features/home_screen/screen/home_screen.dart';

class OtpView extends StatefulWidget {
  final String mobileNumber;
  const OtpView({super.key, required this.mobileNumber});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  int _seconds = 30;
  bool _canResend = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _seconds = 30;
    _canResend = false;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        setState(() => _canResend = true);
        timer.cancel();
      } else {
        setState(() => _seconds--);
      }
    });
  }

  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());

  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  void _resendOtp() {
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }

    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.splashGradient),
        child: Stack(
          children: [
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accentPurple.withValues(alpha: 0.25),
                ),
              ),
            ),
            Positioned(
              bottom: -120,
              left: -120,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.accentCyan.withValues(alpha: 0.18)),
              ),
            ),

            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Verify OTP",
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.white),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Enter the 4-digit OTP sent to your number +91${widget.mobileNumber}",
                        style: TextStyle(fontSize: 14, color: AppColors.white75),
                      ),

                      const SizedBox(height: 30),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(4, (index) {
                          return SizedBox(
                            width: 60,
                            child: TextField(
                              controller: _controllers[index],
                              focusNode: _focusNodes[index],
                              cursorColor: AppColors.primaryColor,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              style: const TextStyle(fontSize: 20, color: AppColors.white, fontWeight: FontWeight.bold),
                              decoration: const InputDecoration(
                                counterText: "",
                                filled: true,
                                fillColor: Colors.white24,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              onChanged: (value) {
                                if (value.isNotEmpty && index < 3) {
                                  _focusNodes[index + 1].requestFocus();
                                }
                                if (value.isEmpty && index > 0) {
                                  _focusNodes[index - 1].requestFocus();
                                }
                              },
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            elevation: 12,
                            shadowColor: AppColors.primaryColor.withValues(alpha: 0.6),
                          ),
                          child: const Text(
                            "Verify & Continue",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.white),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),
                      Center(
                        child: _canResend
                            ? TextButton(
                                onPressed: _resendOtp,
                                child: const Text(
                                  "Resend OTP",
                                  style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w600),
                                ),
                              )
                            : Text(
                                "Resend in ${_seconds}s",
                                style: TextStyle(color: AppColors.white75, fontWeight: FontWeight.w600),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 24,
              right: 24,
              bottom: 20,
              child: SafeArea(
                top: false,
                child: Text(
                  "By continuing, you agree to our Terms & Privacy Policy",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: AppColors.white70),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
