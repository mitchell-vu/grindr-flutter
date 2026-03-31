enum AttachmentType { image, voice, video }

class AttachmentModel {
  final String fileName;
  final AttachmentType type;
  final double? width;
  final double? height;
  final String url;

  AttachmentModel({
    required this.fileName,
    required this.type,
    required this.width,
    required this.height,
    required this.url,
  });

  factory AttachmentModel.fromMap(Map<String, dynamic> map) {
    return AttachmentModel(
      fileName: map['fileName'],
      type: AttachmentType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => AttachmentType.image,
      ),
      width: map['width'],
      height: map['height'],
      url: map['url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fileName': fileName,
      'type': type.name,
      'width': width,
      'height': height,
      'url': url,
    };
  }

  @override
  String toString() {
    return fileName;
  }
}
