import 'package:flutter/material.dart';
import 'package:flutter_profile/responsive.dart';
import 'package:flutter_profile/viewmodels/contact_viewmodel.dart';
import '../../constants.dart';

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

    // Form inputs column
    final formColumn = Column(
      children: [
        TextField(
          controller: _viewModel.nameController,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          decoration: const InputDecoration(
            labelText: AppStrings.nameLabel,
            labelStyle: TextStyle(color: Colors.grey, fontSize: 13),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: 1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 1),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 8),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _viewModel.emailController,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          decoration: const InputDecoration(
            labelText: AppStrings.emailLabelInput,
            labelStyle: TextStyle(color: Colors.grey, fontSize: 13),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: 1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 1),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 8),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _viewModel.messageController,
          maxLines: 3,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          decoration: const InputDecoration(
            labelText: AppStrings.messageLabel,
            labelStyle: TextStyle(color: Colors.grey, fontSize: 13),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: 1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 1),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 8),
          ),
        ),
      ],
    );

    // Left title + button column
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
                formColumn,
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: titleAndButton),
                const SizedBox(width: 60),
                Expanded(child: formColumn),
              ],
            ),
          const SizedBox(height: 80),
          // Footer Name & Copyright
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