class Summary {
  Summary({
    required this.titles,
    required this.pageId,
    required this.extract,
    required this.extractHtml,
    required this.lang,
    required this.dir,
    required this.url,
    this.description,
    this.thumbnail,
    this.originalImage,
  });

  final TitlesSet titles;
  final int pageId;
  final String extract;
  final String extractHtml;
  final String lang;
  final String dir;
  final String url;
  final String? description;
  final ImageFile? thumbnail;
  final ImageFile? originalImage;

  bool get hasImage => originalImage != null && thumbnail != null;

  static Summary fromJson(Map<String, Object?> json) {
    return switch (json) {
      {
        'titles': final Map<String, Object?> titles,
        'pageid': final int pageId,
        'extract': final String extract,
        'extract_html': final String extractHtml,
        'thumbnail': final Map<String, Object?> thumbnail,
        'originalImage': final Map<String, Object?> originalImage,
        'lang': final String lang,
        'dir': final String dir,
        'description': final String description,
        'content_urls': {
          'desktop': {'page': final String url},
          'mobile': {'page': String _},
        },
      } =>
        Summary(
          titles: TitlesSet.fromJson(titles),
          pageId: pageId,
          extract: extract,
          extractHtml: extractHtml,
          thumbnail: ImageFile.fromJson(thumbnail),
          originalImage: ImageFile.fromJson(originalImage),
          lang: lang,
          dir: dir,
          description: description,
          url: url,
        ),
      {
        'titles': final Map<String, Object?> titles,
        'pageid': final int pageId,
        'extract': final String extract,
        'extract_html': final String extractHtml,
        'lang': final String lang,
        'dir': final String dir,
        'description': final String description,
        'content_urls': {
          'desktop': {'page': final String url},
          'mobile': {'page': String _},
        },
      } =>
        Summary(
          titles: TitlesSet.fromJson(titles),
          pageId: pageId,
          extract: extract,
          extractHtml: extractHtml,
          lang: lang,
          dir: dir,
          description: description,
          url: url,
        ),
      {
        'titles': final Map<String, Object?> titles,
        'pageid': final int pageId,
        'extract': final String extract,
        'extract_html': final String extractHtml,
        'lang': final String lang,
        'dir': final String dir,
        'content_urls': {
          'desktop': {'page': final String url},
          'mobile': {'page': String _},
        },
      } =>
        Summary(
          titles: TitlesSet.fromJson(titles),
          pageId: pageId,
          extract: extract,
          extractHtml: extractHtml,
          lang: lang,
          dir: dir,
          url: url,
        ),
      _ => throw FormatException('Could not deserialize Summary, json=$json'),
    };
  }

  @override
  String toString() {
    return 'Summary=['
        'titles=$titles, '
        'pageId=$pageId, '
        'extract=$extract, '
        'extractHtml=$extractHtml, '
        'thumbnail=$thumbnail, '
        'originalImage=${originalImage ?? 'null'}, '
        'lang=$lang, '
        'dir=$dir, '
        'description=$description'
        ']';
  }
}

class ImageFile {
  ImageFile({required this.source, required this.width, required this.height});

  final String source;
  final int width;
  final int height;

  String get extension {
    final extension = getFileExtension(source);
    return extension ?? 'err';
  }

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'source': source,
      'width': width,
      'height': height,
    };
  }

  static ImageFile fromJson(Map<String, Object?> json) {
    if (json case {
      'source': final String source,
      'height': final int height,
      'width': final int width,
    }) {
      return ImageFile(source: source, width: width, height: height);
    }

    throw FormatException('Could not deserialize OriginalImage, json=$json');
  }
}

class TitlesSet {
  TitlesSet({
    required this.canonical,
    required this.normalized,
    required this.display,
  });

  final String canonical;
  final String normalized;
  final String display;

  static TitlesSet fromJson(Map<String, Object?> json) {
    if (json case {
      'canonical': final String canonical,
      'normalized': final String normalized,
      'display': final String display,
    }) {
      return TitlesSet(
        canonical: canonical,
        normalized: normalized,
        display: display,
      );
    }

    throw FormatException('Could not deserialize TitlesSet, json=$json');
  }

  @override
  String toString() =>
      'TitlesSet['
      'canonical=$canonical, '
      'normalized=$normalized, '
      'display=$display'
      ']';
}

String? getFileExtension(String file) {
  final segments = file.split('.');
  if (segments.isNotEmpty) return segments.last;
  return null;
}

const acceptableImageFormats = ['png', 'jpg', 'jpeg'];
