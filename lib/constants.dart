import 'package:flutter_profile/core/theme/app_colors.dart';
import 'package:flutter_profile/core/constants/app_constants.dart';
import 'package:flutter_profile/core/constants/app_strings.dart';

export 'package:flutter_profile/core/theme/app_colors.dart';
export 'package:flutter_profile/core/theme/app_styles.dart';
export 'package:flutter_profile/core/constants/app_constants.dart';
export 'package:flutter_profile/core/constants/app_strings.dart';
export 'package:flutter_profile/models/experience.dart';
export 'package:flutter_profile/models/Recommendation.dart';
export 'package:flutter_profile/models/Project.dart';
export 'package:flutter_profile/data/portfolio_data.dart';

const primaryColor = AppColors.primary;
const secondaryColor = AppColors.secondary;
const darkColor = AppColors.dark;
const bodyTextColor = AppColors.bodyText;
const bgColor = AppColors.bg;
const borderColor = AppColors.border;

const defaultPadding = AppConstants.defaultPadding;
const defaultDuration = AppConstants.defaultDuration;
const maxWidth = AppConstants.maxWidth;

const linkedIn = AppConstants.linkedIn;
const github = AppConstants.github;
const resume = AppConstants.resume;

class Constants {
  static const String appName = AppStrings.appName;
  static final Uri devURL = Uri.parse(AppConstants.devURL);
  static final Uri repoURL = Uri.parse(AppConstants.github);
  static const String copyright = AppStrings.copyright;
}
