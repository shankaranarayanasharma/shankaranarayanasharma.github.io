import 'package:flutter/foundation.dart';
import 'package:flutter_profile/core/constants/app_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class SideMenuViewModel extends ChangeNotifier {
  String get email => AppConstants.email;
  String get phone => AppConstants.phone;
  String get location => AppConstants.location;
  String get resumeUrl => AppConstants.resume;

  String get linkedInUrl => AppConstants.linkedIn;
  String get githubUrl => AppConstants.github;
  String get twitterUrl => AppConstants.twitter;

  Future<void> downloadCV() async {
    final uri = Uri.parse(resumeUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> launchSocial(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
