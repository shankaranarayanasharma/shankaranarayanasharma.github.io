import 'narrative_block.dart';

class EngineeringChallenge {
  final String? number;
  final String title;
  final String? problem;
  final String? approach;
  final String? code;
  final String? codeLanguage;
  final String? image;
  final List<NarrativeBlock> blocks;

  EngineeringChallenge({
    this.number,
    required this.title,
    this.problem,
    this.approach,
    this.code,
    this.codeLanguage,
    this.image,
    this.blocks = const [],
  });

  factory EngineeringChallenge.fromRaw(dynamic raw, int index) {
    final defaultNum = index + 1 < 10 ? '0${index + 1}' : '${index + 1}';
    if (raw is Map<String, dynamic> || raw is Map) {
      final map = Map<String, dynamic>.from(raw);
      return EngineeringChallenge(
        number: map['number']?.toString() ?? defaultNum,
        title: map['title']?.toString() ?? 'Engineering Challenge',
        problem: map['problem']?.toString() ?? map['description']?.toString(),
        approach: map['approach']?.toString() ?? map['solution']?.toString(),
        code: map['code']?.toString() ?? map['snippet']?.toString(),
        codeLanguage:
            map['codeLanguage']?.toString() ?? map['language']?.toString(),
        image: map['image']?.toString() ?? map['url']?.toString(),
        blocks: map['blocks'] != null
            ? NarrativeBlock.fromRaw(map['blocks'])
            : [],
      );
    }
    return EngineeringChallenge(
      number: defaultNum,
      title: 'Engineering Challenge',
      problem: raw?.toString(),
    );
  }
}
