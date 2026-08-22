enum NarrativeBlockType { heading, paragraph, points, image, images, video }

class NarrativeBlock {
  final NarrativeBlockType type;
  final String? text;
  final List<String>? items;
  final String? iconStyle;
  final String? url;
  final List<String>? urls;
  final String? caption;

  NarrativeBlock({
    required this.type,
    this.text,
    this.items,
    this.iconStyle,
    this.url,
    this.urls,
    this.caption,
  });

  static List<NarrativeBlock> fromRaw(dynamic raw) {
    if (raw == null) return [];

    if (raw is List) {
      final blocks = <NarrativeBlock>[];
      for (final item in raw) {
        if (item is Map<String, dynamic> || item is Map) {
          final map = Map<String, dynamic>.from(item);
          final typeStr = map['type']?.toString().toLowerCase() ?? 'paragraph';
          if (typeStr == 'heading' ||
              typeStr == 'title' ||
              typeStr == 'subheading') {
            blocks.add(NarrativeBlock(
              type: NarrativeBlockType.heading,
              text: map['text']?.toString() ??
                  map['title']?.toString() ??
                  map['heading']?.toString() ??
                  '',
            ));
          } else if (typeStr == 'points' || typeStr == 'bullets') {
            blocks.add(NarrativeBlock(
              type: NarrativeBlockType.points,
              items: List<String>.from(map['items'] ?? map['points'] ?? []),
              iconStyle: map['iconStyle']?.toString(),
            ));
          } else if (typeStr == 'image') {
            blocks.add(NarrativeBlock(
              type: NarrativeBlockType.image,
              url: map['url']?.toString() ?? map['image']?.toString(),
              caption: map['caption']?.toString(),
            ));
          } else if (typeStr == 'images') {
            blocks.add(NarrativeBlock(
              type: NarrativeBlockType.images,
              urls: List<String>.from(map['urls'] ?? map['images'] ?? []),
              caption: map['caption']?.toString(),
            ));
          } else if (typeStr == 'video') {
            blocks.add(NarrativeBlock(
              type: NarrativeBlockType.video,
              url: map['url']?.toString() ?? map['video']?.toString(),
              caption: map['caption']?.toString(),
            ));
          } else {
            blocks.add(NarrativeBlock(
              type: NarrativeBlockType.paragraph,
              text: map['text']?.toString() ??
                  map['content']?.toString() ??
                  map['overview']?.toString() ??
                  '',
            ));
          }
        } else if (item is String) {
          blocks.add(NarrativeBlock(
            type: NarrativeBlockType.paragraph,
            text: item,
          ));
        }
      }
      return blocks;
    }

    if (raw is Map) {
      final map = Map<String, dynamic>.from(raw);
      final blocks = <NarrativeBlock>[];
      if (map.containsKey('heading') || map.containsKey('subheading')) {
        final h = (map['heading'] ?? map['subheading'])?.toString();
        if (h != null && h.isNotEmpty) {
          blocks.add(NarrativeBlock(
            type: NarrativeBlockType.heading,
            text: h,
          ));
        }
      }
      if (map.containsKey('overview') ||
          map.containsKey('text') ||
          map.containsKey('description')) {
        final txt =
            (map['overview'] ?? map['text'] ?? map['description'])?.toString();
        if (txt != null && txt.isNotEmpty) {
          blocks.add(NarrativeBlock(
            type: NarrativeBlockType.paragraph,
            text: txt,
          ));
        }
      }
      if (map.containsKey('video')) {
        final v = map['video']?.toString();
        if (v != null && v.isNotEmpty) {
          blocks.add(NarrativeBlock(
            type: NarrativeBlockType.video,
            url: v,
            caption: map['caption']?.toString(),
          ));
        }
      }
      if (map.containsKey('points') || map.containsKey('items')) {
        final pts = List<String>.from(map['points'] ?? map['items'] ?? []);
        if (pts.isNotEmpty) {
          blocks.add(NarrativeBlock(
            type: NarrativeBlockType.points,
            items: pts,
            iconStyle: map['iconStyle']?.toString(),
          ));
        }
      }
      if (map.containsKey('image') || map.containsKey('url')) {
        final u = (map['image'] ?? map['url'])?.toString();
        if (u != null && u.isNotEmpty) {
          blocks.add(NarrativeBlock(
            type: NarrativeBlockType.image,
            url: u,
            caption: map['caption']?.toString(),
          ));
        }
      }
      if (blocks.isNotEmpty) return blocks;
    }

    if (raw is String && raw.trim().isNotEmpty) {
      return [
        NarrativeBlock(
          type: NarrativeBlockType.paragraph,
          text: raw,
        )
      ];
    }

    return [];
  }
}

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

class Project {
  final String title;
  final String description;
  final String image;
  final List<String> categories;
  final List<String> media; // image or video URLs
  final Map<String, List<String>>? mediaByPlatform; // platform-specific media URLs
  final List<String> technologies;
  final String? github;
  final String? playStore;
  final String? appStore;

  final String? year;
  final String? role;
  final String? projectType;

  final List<String>? pointByPointSections;

  // Engineering Challenges Section
  final List<EngineeringChallenge> engineeringChallenges;

  // Block-based Narrative Fields
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

    Map<String, List<String>>? parsedMediaByPlatform;
    if (json['mediaByPlatform'] is Map) {
      parsedMediaByPlatform = {};
      (json['mediaByPlatform'] as Map).forEach((k, v) {
        if (v is List) {
          parsedMediaByPlatform![k.toString()] =
              List<String>.from(v.map((e) => e.toString()));
        }
      });
    } else {
      final rawMedia = List<String>.from(json['media'] ?? []);
      final autoGrouped = <String, List<String>>{};
      for (final path in rawMedia) {
        final lower = path.toLowerCase();
        String? platformKey;
        if (lower.contains('/android/') ||
            lower.contains('_android') ||
            lower.contains('-android')) {
          platformKey = "Android";
        } else if (lower.contains('/iphone/') ||
            lower.contains('/ios/') ||
            lower.contains('_iphone') ||
            lower.contains('_ios')) {
          platformKey = "iPhone";
        } else if (lower.contains('/ipad/') || lower.contains('_ipad')) {
          platformKey = "iPad";
        } else if (lower.contains('/tablet/') || lower.contains('_tablet')) {
          platformKey = "Tablet";
        } else if (lower.contains('/macos/') ||
            lower.contains('/mac/') ||
            lower.contains('_mac')) {
          platformKey = "Mac OS";
        } else if (lower.contains('/web/') || lower.contains('_web')) {
          platformKey = "Web";
        }

        if (platformKey != null) {
          autoGrouped.putIfAbsent(platformKey, () => []).add(path);
        }
      }
      if (autoGrouped.isNotEmpty) {
        parsedMediaByPlatform = autoGrouped;
      }
    }

    return Project(
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      categories: List<String>.from(json['categories'] ?? []),
      media: List<String>.from(json['media'] ?? []),
      mediaByPlatform: parsedMediaByPlatform,
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

  // Legacy string getters for backward compatibility
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
