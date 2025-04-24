class FileEntity{
  final String? name;
  final String? path;

  FileEntity({this.name, this.path});

  FileEntity copyWith({String? name, String? path}) {
    return FileEntity(
      name: name ?? this.name,
      path: path ?? this.path,
    );
  }
}
