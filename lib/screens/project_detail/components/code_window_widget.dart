import 'package:flutter/material.dart';

class CodeWindowWidget extends StatelessWidget {
  final String code;
  final String? language;

  const CodeWindowWidget({
    Key? key,
    required this.code,
    this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF101014),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.03),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(13)),
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withValues(alpha: 0.06),
                ),
              ),
            ),
            child: Row(
              children: [
                Row(
                  children: [
                    _dot(const Color(0xFFFF5F56)),
                    const SizedBox(width: 6),
                    _dot(const Color(0xFFFFBD2E)),
                    const SizedBox(width: 6),
                    _dot(const Color(0xFF27C93F)),
                  ],
                ),
                const Spacer(),
                if (language != null && language!.isNotEmpty)
                  Text(
                    language!.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.4),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SelectableText.rich(
                _highlightCode(code),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot(Color color) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  TextSpan _highlightCode(String input) {
    final spans = <TextSpan>[];
    final lines = input.split('\n');

    final keywords = {
      'const', 'let', 'var', 'async', 'await', 'try', 'catch', 'function',
      'return', 'if', 'else', 'class', 'import', 'export', 'from', 'final',
      'void', 'throw', 'new', 'typedef', 'struct', 'enum'
    };

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];

      if (line.trimLeft().startsWith('//')) {
        spans.add(TextSpan(
          text: line,
          style: const TextStyle(
            color: Color(0xFF6A9955),
            fontFamily: 'monospace',
            fontSize: 12.5,
            height: 1.5,
          ),
        ));
      } else {
        final words = line.split(RegExp(r'(?<=\s|\(|\)|\{|\}|\[|\]|;|,|\.)|(?=\s|\(|\)|\{|\}|\[|\]|;|,|\.)'));
        for (final word in words) {
          Color color = Colors.white70;
          FontWeight weight = FontWeight.normal;

          final trimmed = word.trim();
          if (keywords.contains(trimmed)) {
            color = const Color(0xFFFF79C6);
            weight = FontWeight.bold;
          } else if (RegExp(r'^[0-9]+$').hasMatch(trimmed)) {
            color = const Color(0xFFBD93F9);
          } else if (trimmed.startsWith("'") || trimmed.startsWith('"')) {
            color = const Color(0xFFF1FA8C);
          } else if (trimmed == '=>' || trimmed == '=' || trimmed == '+' || trimmed == '-') {
            color = const Color(0xFFFF79C6);
          }

          spans.add(TextSpan(
            text: word,
            style: TextStyle(
              color: color,
              fontWeight: weight,
              fontFamily: 'monospace',
              fontSize: 12.5,
              height: 1.5,
            ),
          ));
        }
      }

      if (i < lines.length - 1) {
        spans.add(const TextSpan(text: '\n'));
      }
    }

    return TextSpan(children: spans);
  }
}
