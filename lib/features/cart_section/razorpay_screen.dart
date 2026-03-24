import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:zeggo_cus/constants/app_toast.dart';

class RazorpayScreen extends StatefulWidget {
  final String orderId;
  final double amount;
  final String name;
  final String email;
  final String contact;

  final Function(PaymentSuccessResponse)? onSuccess;
  final Function(PaymentFailureResponse)? onFailure;
  const RazorpayScreen({
    super.key,
    required this.orderId,
    required this.amount,
    required this.name,
    required this.email,
    required this.contact,
    this.onSuccess,
    this.onFailure,
  });

  @override
  State<RazorpayScreen> createState() => _RazorpayScreenState();
}

class _RazorpayScreenState extends State<RazorpayScreen> {
  late Razorpay _razorpay;
  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);

    Future.microtask(() => openRazorpayCheckout(widget.orderId, widget.amount.toString()));
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void openRazorpayCheckout(String orderId, String amount) {
    var options = {
      'key': "rzp_live_STONgTdVGEXe3x",
      'amount': amount,
      'order_id': orderId,
      'name': widget.name,
      'description': "No Description",
      'prefill': {'contact': widget.contact, 'email': widget.email},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint("Error: $e");
      AppToast.showError(context, "Failed to open Razorpay checkout", "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    AppToast.showError(context, "Payment Failed", response.message ?? "Something went wrong");

    widget.onFailure?.call(response);

    Navigator.pop(context);
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    AppToast.showSuccess(context, "Payment Success", "Payment ID: ${response.paymentId}");

    widget.onSuccess?.call(response);

    Navigator.pop(context); // go back
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(context, "External Wallet Selected", "Wallet: ${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(title: Text(title), content: Text(message)),
    );
  }
}
