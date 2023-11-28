import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dialogs_utils.dart';

void showPrivacyPolicy(BuildContext context) async {
  Uri url = Uri.parse('https://www.google.com');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    showAlert(context, 'Não foi possível abrir a política de privacidade.');
  }
}
