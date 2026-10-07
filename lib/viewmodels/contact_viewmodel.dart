import 'package:flutter/material.dart';
import 'package:flutter_profile/core/constants/app_strings.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:convert';

class ContactViewModel extends ChangeNotifier {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  bool _isSending = false;
  bool _isDisposed = false;

  bool get isSending => _isSending;

  static const String _serviceId = 'service_8htvbpe';
  static const String _templateId = 'template_05fkeac';
  static const String _publicKey = 'Rhe0uf5vvbExv8jdN';

  void _safeNotifyListeners() {
    if (!_isDisposed) notifyListeners();
  }

  Future<void> submitForm(BuildContext context) async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final message = messageController.text.trim();

    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      _showSnackBar(context, AppStrings.validationError, Colors.redAccent);
      return;
    }

    _isSending = true;
    _safeNotifyListeners();

    try {
      final response = await html.HttpRequest.request(
        'https://api.emailjs.com/api/v1.0/email/send',
        method: 'POST',
        mimeType: 'application/json',
        requestHeaders: {'Content-Type': 'application/json'},
        sendData: jsonEncode({
          'service_id': _serviceId,
          'template_id': _templateId,
          'user_id': _publicKey,
          'template_params': {
            'from_name': name,
            'from_email': email,
            'message': message,
            'to_email': 'shankaranarayanasharma@gmail.com',
          },
        }),
      );

      if (response.status == 200) {
        nameController.clear();
        emailController.clear();
        messageController.clear();
        if (context.mounted) {
          _showSnackBar(context, AppStrings.mailSentSuccess, Colors.green);
        }
      } else {
        throw Exception('Status: ${response.status} - ${response.responseText}');
      }
    } catch (e) {
      debugPrint('EmailJS error: $e');
      if (context.mounted) {
        _showSnackBar(context, AppStrings.mailError, Colors.redAccent);
      }
    } finally {
      _isSending = false;
      _safeNotifyListeners();
    }
  }

  void _showSnackBar(BuildContext context, String message, Color bgColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: bgColor,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  void dispose() {
    _isDisposed = true;
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }
}
