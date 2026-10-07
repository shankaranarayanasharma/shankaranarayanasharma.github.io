import 'engineering_challenge.dart';
import 'narrative_block.dart';
import 'project_media_parser.dart';

export 'engineering_challenge.dart';
export 'narrative_block.dart';

class Project {
  final String title;
  final String description;
  final String image;
  final List<String> categories;
  final List<String> media;
  final Map<String, List<String>>? mediaByPlatform;

  /// Whether the gallery media already contains a device bezel/mockup.
  final bool mediaHasBezel;
  final List<String> technologies;
  final String? github;
  final String? playStore;
  final String? appStore;

  final String? year;
  final String? role;
  final String? projectType;

  final List<String>? pointByPointSections;

  final List<EngineeringChallenge> engineeringChallenges;

  final List<NarrativeBlock> backstoryBlocks;
  final List<NarrativeBlock> myRoleBlocks;
  final List<NarrativeBlock> challengeBlocks;
  final List<NarrativeBlock> approachBlocks;
  final List<NarrativeBlock> solutionBlocks;
  final List<NarrativeBlock> keyOutcomesBlocks;
  final List<NarrativeBlock> whatMakesThisDifferentBlocks;
  final List<NarrativeBlock> whatITookFromItBlocks;

  Project({
    required this.title,
    required this.description,
    required this.image,
    required this.categories,
    required this.media,
    this.mediaByPlatform,
    this.mediaHasBezel = false,
    required this.technologies,
    this.github,
    this.playStore,
    this.appStore,
    this.year,
    this.role,
    this.projectType,
    this.pointByPointSections,
    this.engineeringChallenges = const [],
    this.backstoryBlocks = const [],
    this.myRoleBlocks = const [],
    this.challengeBlocks = const [],
    this.approachBlocks = const [],
    this.solutionBlocks = const [],
    this.keyOutcomesBlocks = const [],
    this.whatMakesThisDifferentBlocks = const [],
    this.whatITookFromItBlocks = const [],
  });

  bool get hasEngineeringChallenges => engineeringChallenges.isNotEmpty;

  factory Project.fromJson(Map<String, dynamic> json) {
    String? pType;
    List<String> parsedTypes = [];

    final rawPt = json['projectType'];
    if (rawPt is List) {
      parsedTypes = List<String>.from(rawPt.map((e) => e.toString()));
      pType = parsedTypes.join(', ');
    } else if (rawPt is String && rawPt.trim().isNotEmpty) {
      pType = rawPt;
      parsedTypes = rawPt
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();
    }

    final rawEng = json['engineeringChallenges'] ?? json['engineering'];
    List<EngineeringChallenge> parsedEng = [];
    if (rawEng is List) {
      parsedEng = rawEng
          .asMap()
          .entries
          .map((e) => EngineeringChallenge.fromRaw(e.value, e.key))
          .toList();
    }

    final rawMedia = List<String>.from(json['media'] ?? []);
    final parsedMediaByPlatform = ProjectMediaParser.parseMediaByPlatform(
      json['mediaByPlatform'],
      rawMedia,
    );

    return Project(
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      categories: List<String>.from(json['categories'] ?? []),
      media: rawMedia,
      mediaByPlatform: parsedMediaByPlatform,
      mediaHasBezel: json['mediaHasBezel'] == true,
      technologies: List<String>.from(json['technologies'] ?? []),
      github: json['github'] as String?,
      playStore: json['playStore'] as String?,
      appStore: json['appStore'] as String?,
      year: json['year'] as String?,
      role: json['role'] as String?,
      projectType: pType,
      pointByPointSections: json['pointByPointSections'] != null
          ? List<String>.from(json['pointByPointSections'])
          : null,
      engineeringChallenges: parsedEng,
      backstoryBlocks: NarrativeBlock.fromRaw(json['backstory']),
      myRoleBlocks: NarrativeBlock.fromRaw(json['myRole']),
      challengeBlocks: NarrativeBlock.fromRaw(json['challenge']),
      approachBlocks: NarrativeBlock.fromRaw(json['approach']),
      solutionBlocks: NarrativeBlock.fromRaw(json['solution']),
      keyOutcomesBlocks: NarrativeBlock.fromRaw(json['keyOutcomes']),
      whatMakesThisDifferentBlocks:
          NarrativeBlock.fromRaw(json['whatMakesThisDifferent']),
      whatITookFromItBlocks: NarrativeBlock.fromRaw(json['whatITookFromIt']),
    );
  }

  String? get backstory => _blocksToString(backstoryBlocks);
  String? get myRole => _blocksToString(myRoleBlocks);
  String? get challenge => _blocksToString(challengeBlocks);
  String? get approach => _blocksToString(approachBlocks);
  String? get solution => _blocksToString(solutionBlocks);
  String? get keyOutcomes => _blocksToString(keyOutcomesBlocks);
  String? get whatMakesThisDifferent =>
      _blocksToString(whatMakesThisDifferentBlocks);
  String? get whatITookFromIt => _blocksToString(whatITookFromItBlocks);

  static String? _blocksToString(List<NarrativeBlock> blocks) {
    if (blocks.isEmpty) return null;
    final parts = <String>[];
    for (final b in blocks) {
      if (b.text != null && b.text!.isNotEmpty) parts.add(b.text!);
      if (b.items != null && b.items!.isNotEmpty) {
        parts.add(b.items!.join('\n'));
      }
    }
    return parts.isEmpty ? null : parts.join('\n\n');
  }

  bool isSectionPointByPoint(String sectionKey, [bool defaultValue = false]) {
    if (pointByPointSections != null) {
      return pointByPointSections!.contains(sectionKey);
    }
    return defaultValue;
  }

  String get displayYear => year ?? '2023';

  String get displayRole {
    if (role != null && role!.trim().isNotEmpty) {
      return role!;
    }
    return '';
  }

  List<String> get displayTypes {
    if (projectType != null && projectType!.isNotEmpty) {
      final split = projectType!
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();
      if (split.isNotEmpty) return split;
    }
    if (categories.isNotEmpty) {
      return categories.map((c) {
        if (c.toLowerCase().contains('app')) return c;
        return '$c App';
      }).toList();
    }
    return ['Web App'];
  }

  String get displayType => displayTypes.first;
}
