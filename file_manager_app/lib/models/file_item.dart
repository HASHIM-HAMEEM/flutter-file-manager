class FileItem {
  final int? id;
  final String name;
  final String path;
  final String category;
  final DateTime dateAdded;
  final String fileType;

  FileItem({
    this.id,
    required this.name,
    required this.path,
    required this.category,
    required this.dateAdded,
    required this.fileType,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'path': path,
      'category': category,
      'dateAdded': dateAdded.toIso8601String(),
      'fileType': fileType,
    };
  }

  factory FileItem.fromMap(Map<String, dynamic> map) {
    return FileItem(
      id: map['id'],
      name: map['name'],
      path: map['path'],
      category: map['category'],
      dateAdded: DateTime.parse(map['dateAdded']),
      fileType: map['fileType'],
    );
  }
}
