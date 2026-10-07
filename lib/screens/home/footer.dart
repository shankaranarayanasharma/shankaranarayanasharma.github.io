import 'package:flutter/material.dart';
import 'package:flutter_profile/responsive.dart';
import 'package:flutter_profile/viewmodels/contact_viewmodel.dart';
import '../../constants.dart';
import 'components/contact_form_fields.dart';

class DS8Footer extends StatefulWidget {
  const DS8Footer({Key? key}) : super(key: key);

  @override
  State<DS8Footer> createState() => _DS8FooterState();
}

class _DS8FooterState extends State<DS8Footer> {
  final ContactViewModel _viewModel = ContactViewModel();

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    final titleAndButton = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.contactTitle,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 32),
        ListenableBuilder(
          listenable: _viewModel,
          builder: (context, _) {
            return ElevatedButton(
              onPressed: _viewModel.isSending
                  ? null
                  : () => _viewModel.submitForm(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
                disabledBackgroundColor: AppColors.accent.withValues(alpha: 0.6),
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: _viewModel.isSending
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text(
                      AppStrings.contactSubmit,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
            );
          },
        ),
      ],
    );

    return Container(
      width: double.infinity,
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.contact,
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
          const SizedBox(height: 40),
          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleAndButton,
                const SizedBox(height: 40),
                ContactFormFields(viewModel: _viewModel),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: titleAndButton),
                const SizedBox(width: 60),
                Expanded(child: ContactFormFields(viewModel: _viewModel)),
              ],
            ),
          const SizedBox(height: 80),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: const [
                Text(
                  AppStrings.appName,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  AppStrings.copyright,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: bodyTextColor, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}