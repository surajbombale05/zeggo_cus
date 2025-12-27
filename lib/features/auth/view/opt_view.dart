import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zeggo_cus/constants/app_colors.dart';
import 'package:zeggo_cus/features/home_screen/screen/home_screen.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

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
                        "Enter the 4-digit OTP sent to your number",
                        style: TextStyle(fontSize: 14, color: AppColors.white75),
                      ),

                      const SizedBox(height: 30),

                      // ================= OTP INPUT =================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(4, (index) {
                          return _otpBox();
                        }),
                      ),

                      const SizedBox(height: 30),

                      // ================= VERIFY BUTTON =================
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accentPurple,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            elevation: 12,
                            shadowColor: AppColors.accentPurple.withValues(alpha: 0.6),
                          ),
                          child: const Text(
                            "Verify & Continue",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.white),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      Center(
                        child: TextButton(
                          onPressed: () {
                          },
                          child: const Text(
                            "Resend OTP",
                            style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w600),
                          ),
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

  // ================= OTP BOX =================
  Widget _otpBox() {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha:0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha:0.25)),
      ),
      child: TextField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.white),
        decoration: const InputDecoration(counterText: "", border: InputBorder.none),
      ),
    );
  }
}
