import 'package:flutter/material.dart';
import 'package:flutter_profile/constants.dart';
import 'package:flutter_profile/responsive.dart';
import 'package:flutter_profile/viewmodels/side_menu_viewmodel.dart';
import 'package:flutter_svg/svg.dart';
import 'my_info.dart';

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

class ContactItemTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ContactItemTile({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFF212124),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: borderColor, width: 1),
            ),
            child: Icon(icon, color: primaryColor, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SocialIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final String asset;

  const SocialIconButton({
    Key? key,
    required this.onTap,
    required this.asset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFF212124),
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: 1),
          ),
          padding: const EdgeInsets.all(8),
          child: SvgPicture.asset(
            asset,
            colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
