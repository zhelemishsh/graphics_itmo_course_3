class Layer {
  String name;
  double top;
  double left;
  double width;
  double height;
  bool isVisible = true;

  Layer({
    required this.name,
    required this.width,
    required this.height,
    this.left = 0,
    this.top = 0,
  });
}