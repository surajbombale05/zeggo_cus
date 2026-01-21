import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zeggo_cus/constants/app_colors.dart';
import 'package:zeggo_cus/constants/app_toast.dart';
import 'package:zeggo_cus/features/auth/bloc/send_otp/send_otp_cubit.dart';
import 'package:zeggo_cus/features/auth/view/opt_view.dart';
import 'package:zeggo_cus/features/home_screen/screen/home_screen.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      // bottomNavigationBar: Container(
      //   color: Colors.transparent,
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      //     child: Text(
      //       "By continuing, you agree to our Terms & Privacy Policy",
      //       textAlign: TextAlign.center,
      //       style: TextStyle(fontSize: 12, color: AppColors.white70),
      //     ),
      //   ),
      // ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
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
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accentCyan.withValues(alpha: 0.18),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: SafeArea(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.kGreyColor.withValues(alpha: 0.1),
                        border: Border.all(color: AppColors.kGreyColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 5),
                          Text(
                            "Skip",
                            style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(width: 2),
                          Icon(Icons.navigate_next_outlined, color: AppColors.white),
                        ],
                      ),
                    ),
                  ),
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
                        Text(
                          "Zeggo",
                          style: GoogleFonts.scheherazadeNew(
                            fontSize: 65,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),

                        const SizedBox(height: 8),
                        Text(
                          "Groceries at your door \nfast & fresh",
                          style: TextStyle(fontSize: 19, color: AppColors.white),
                        ),
                        const SizedBox(height: 50),

                        Text(
                          "Enter your mobile number to continue",
                          style: TextStyle(fontSize: 14, color: AppColors.white75),
                        ),

                        const SizedBox(height: 15),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: AppColors.white.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.white.withValues(alpha: 0.2)),
                          ),
                          child: Row(
                            children: [
                              const Text(
                                "+91",
                                style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  controller: numberController,
                                  keyboardType: TextInputType.phone,
                                  maxLength: 10,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  style: const TextStyle(color: AppColors.white, fontSize: 16),
                                  decoration: InputDecoration(
                                    counterText: "",
                                    hintText: "Mobile Number",
                                    hintStyle: TextStyle(color: AppColors.white70),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),
                        BlocConsumer<SendOtpCubit, SendOtpState>(
                          listener: (context, state) {
                            if (state is SendOtpErrorState) {
                              AppToast.showError(context, "", state.error);
                              return;
                            }
                            if (state is SendOtpLoadedState) {
                              AppToast.showSuccess(context, "", "${state.model.message}");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => OtpView(
                                    mobileNumber: numberController.text.trim(),
                                    otp: state.model.data?.otp ?? "",
                                  ),
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            return state is SendOtpLoadingState
                                ? Center(child: CircularProgressIndicator())
                                : SizedBox(
                                    width: double.infinity,
                                    height: 54,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (numberController.text.isEmpty) {
                                          AppToast.showError(context, "Error !", "Please enter mobile number");
                                          return;
                                        }
                                        context.read<SendOtpCubit>().sendOtp(numberController.text.trim());
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primaryColor,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                        elevation: 12,
                                        shadowColor: AppColors.primaryColor.withValues(alpha: 0.6),
                                      ),
                                      child: const Text(
                                        "Continue",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ),
                                  );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Positioned(
              //   left: 24,
              //   right: 24,
              //   bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              //   child: SafeArea(
              //     top: false,
              //     child: Text(
              //       "By continuing, you agree to our Terms & Privacy Policy",
              //       textAlign: TextAlign.center,
              //       style: TextStyle(fontSize: 12, color: AppColors.white70),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
