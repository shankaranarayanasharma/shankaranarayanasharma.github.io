import 'package:flutter/material.dart';
import 'package:flutter_profile/constants.dart';
import 'package:flutter_profile/responsive.dart';
import 'package:flutter_profile/viewmodels/side_menu_viewmodel.dart';
import 'package:flutter_svg/svg.dart';
import 'my_info.dart';
import 'side_menu_widgets.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final SideMenuViewModel _viewModel = SideMenuViewModel();

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final menuContent = Column(
      children: [
        const MyInfo(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: 8),
            child: Column(
              children: [
                const Divider(color: borderColor, thickness: 1, height: 24),
                ContactItemTile(
                  icon: Icons.mail_outline_rounded,
                  label: AppStrings.emailLabel,
                  value: _viewModel.email,
                ),
                ContactItemTile(
                  icon: Icons.phone_android_rounded,
                  label: AppStrings.phoneLabel,
                  value: _viewModel.phone,
                ),
                ContactItemTile(
                  icon: Icons.location_on_outlined,
                  label: AppStrings.locationLabel,
                  value: _viewModel.location,
                ),
                const Divider(color: borderColor, thickness: 1, height: 24),
                TextButton(
                  onPressed: _viewModel.downloadCV,
                  child: FittedBox(
                    child: Row(
                      children: [
                        Text(
                          AppStrings.downloadCv,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: defaultPadding / 2),
                        SvgPicture.asset(
                          "assets/icons/download.svg",
                          colorFilter: const ColorFilter.mode(
                              Colors.grey, BlendMode.srcIn),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialIconButton(
                      onTap: () => _viewModel.launchSocial(_viewModel.linkedInUrl),
                      asset: "assets/icons/linkedin.svg",
                    ),
                    const SizedBox(width: 12),
                    SocialIconButton(
                      onTap: () => _viewModel.launchSocial(_viewModel.githubUrl),
                      asset: "assets/icons/github.svg",
                    ),
                    const SizedBox(width: 12),
                    SocialIconButton(
                      onTap: () => _viewModel.launchSocial(_viewModel.twitterUrl),
                      asset: "assets/icons/twitter.svg",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );

    if (Responsive.isDesktop(context)) {
      return Container(
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: menuContent,
      );
    } else {
      return Drawer(
        backgroundColor: secondaryColor,
        child: SafeArea(child: menuContent),
      );
    }
  }
}
