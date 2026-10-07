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
