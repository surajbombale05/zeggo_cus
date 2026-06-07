import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:play_install_referrer/play_install_referrer.dart';
import 'package:zeggo_cus/utils/storage/storage.dart';
import 'dart:developer';
import 'dart:io';

class DeepLinkService {
  static final DeepLinkService _instance = DeepLinkService._internal();
  factory DeepLinkService() => _instance;
  DeepLinkService._internal();

  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  Future<void> init() async {
    _appLinks = AppLinks();
    if (Platform.isAndroid) {
      _checkInstallReferrer();
    }

    final initialLink = await _appLinks.getInitialLink();
    if (initialLink != null) {
      _handleLink(initialLink);
    }

    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      _handleLink(uri);
    });
  }

  Future<void> _checkInstallReferrer() async {
    try {
      ReferrerDetails details = await PlayInstallReferrer.installReferrer;
      log("Install Referrer: ${details.installReferrer}");

      String? referrer = details.installReferrer;
      if (referrer != null &&
          referrer != "utm_source=google-play&utm_medium=organic") {
        LocalStorageUtils.saveReferralCode(referrer);
      }
    } catch (e) {
      log("Error checking install referrer: $e");
    }
  }

  void _handleLink(Uri uri) {
    log("Deep Link received: $uri");
    if (uri.path.contains('refer') ||
        uri.queryParameters.containsKey('ref') ||
        uri.queryParameters.containsKey('code')) {
      final code = uri.queryParameters['ref'] ?? uri.queryParameters['code'];
      if (code != null) {
        log("Referral code found: $code");
        LocalStorageUtils.saveReferralCode(code);
      }
    }
  }

  void dispose() {
    _linkSubscription?.cancel();
  }
}
