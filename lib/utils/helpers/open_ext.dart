import 'package:url_launcher/url_launcher.dart';

void openUrlInBrowser(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Impossible d\'ouvrir l\'URL : $url';
  }
}
