import 'package:flutter/material.dart';
import 'package:flutter_profile/viewmodels/contact_viewmodel.dart';
import '../../../constants.dart';

class ContactFormFields extends StatelessWidget {
  final ContactViewModel viewModel;

  const ContactFormFields({Key? key, required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: viewModel.nameController,
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
          controller: viewModel.emailController,
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
          controller: viewModel.messageController,
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
  }
}
