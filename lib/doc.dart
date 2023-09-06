class Doc {
  final String path;
  final String content;

  Doc(this.path, this.content);

  @override
  String toString() => 'Doc(path: $path, content: $content)';
}
