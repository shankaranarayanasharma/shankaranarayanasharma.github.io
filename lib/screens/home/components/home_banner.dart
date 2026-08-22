import 'package:flutter/material.dart';
import 'package:flutter_profile/responsive.dart';
import '../../../constants.dart';
import 'heighlights.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double cardSpacing = 16.0;
    Widget serviceCards;

    if (Responsive.isMobile(context)) {
      serviceCards = Column(
        children: const [
          ServiceCard(
            icon: Icons.smartphone_rounded,
            title: AppStrings.serviceMobileTitle,
            description: AppStrings.serviceMobileDesc,
          ),
          SizedBox(height: cardSpacing),
          ServiceCard(
            icon: Icons.code_rounded,
            title: AppStrings.serviceWebTitle,
            description: AppStrings.serviceWebDesc,
          ),
          SizedBox(height: cardSpacing),
          ServiceCard(
            icon: Icons.design_services_outlined,
            title: AppStrings.serviceUiTitle,
            description: AppStrings.serviceUiDesc,
          ),
          SizedBox(height: cardSpacing),
          ServiceCard(
            icon: Icons.dns_rounded,
            title: AppStrings.serviceBackendTitle,
            description: AppStrings.serviceBackendDesc,
          ),
        ],
      );
    } else {
      serviceCards = Column(
        children: [
          Row(
            children: const [
              Expanded(
                child: ServiceCard(
                  icon: Icons.smartphone_rounded,
                  title: AppStrings.serviceMobileTitle,
                  description: AppStrings.serviceMobileDesc,
                ),
              ),
              SizedBox(width: cardSpacing),
              Expanded(
                child: ServiceCard(
                  icon: Icons.code_rounded,
                  title: AppStrings.serviceWebTitle,
                  description: AppStrings.serviceWebDesc,
                ),
              ),
            ],
          ),
          const SizedBox(height: cardSpacing),
          Row(
            children: const [
              Expanded(
                child: ServiceCard(
                  icon: Icons.design_services_outlined,
                  title: AppStrings.serviceUiTitle,
                  description: AppStrings.serviceUiDesc,
                ),
              ),
              SizedBox(width: cardSpacing),
              Expanded(
                child: ServiceCard(
                  icon: Icons.dns_rounded,
                  title: AppStrings.serviceBackendTitle,
                  description: AppStrings.serviceBackendDesc,
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.aboutMe,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 36,
          height: 4,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          AppStrings.aboutMeParagraph1,
          style: TextStyle(
            fontSize: 14,
            color: bodyTextColor,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          AppStrings.aboutMeParagraph2,
          style: TextStyle(
            fontSize: 14,
            color: bodyTextColor,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          AppStrings.aboutMeParagraph3,
          style: TextStyle(
            fontSize: 14,
            color: bodyTextColor,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          AppStrings.aboutMeParagraph4,
          style: TextStyle(
            fontSize: 14,
            color: bodyTextColor,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 32),
        const HighLightsInfo(),
        const SizedBox(height: 40),
        const Text(
          AppStrings.whatImDoing,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 36,
          height: 4,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 20),
        serviceCards,
        const SizedBox(height: 24),
      ],
    );
  }
}

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const ServiceCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF212124),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: primaryColor, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
