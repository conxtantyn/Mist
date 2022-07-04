class Screen {
  final double width;
  final double height;

  final bool allowFontScaling;

  const Screen({
    this.width = 414,
    this.height = 896,
    this.allowFontScaling = true,
  });

  @override
  String toString() => '$runtimeType($width, $height, $allowFontScaling)';
}
