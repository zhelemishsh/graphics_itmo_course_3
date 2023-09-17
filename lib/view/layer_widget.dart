import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graphics/view/transform_square.dart';

import '../models/layer.dart';

class LayerWidget extends StatefulWidget {
  final Layer layer;

  const LayerWidget({
    Key? key,
    required this.layer,
  }) : super(key: key);

  @override
  LayerWidgetState createState() {
    return LayerWidgetState();
  }
}

class LayerWidgetState extends State<LayerWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.layer.top,
      left: widget.layer.left,
      child: Draggable(
        feedback: Container(),
        onDragUpdate: (details) {
          widget.layer.top += details.delta.dy;
          widget.layer.left += details.delta.dx;
          setState(() {});
        },
        child: widget.layer.isVisible ? _layerContainer() : Container(),
      ),
    );
  }

  Widget _layerContainer() {
    return Container(
      width: widget.layer.width,
      height: widget.layer.height,
      decoration: const BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: 4,),],
      ),
      child: Stack(
        children: [
          Container(
            color: Colors.red,
            alignment: Alignment.center,
            child: Text(widget.layer.name),
          ),
          TransformSquare.topLeft(_onTransformed),
          TransformSquare.topCenter(_onTransformed),
          TransformSquare.topRight(_onTransformed),
          TransformSquare.centerLeft(_onTransformed),
          TransformSquare.centerRight(_onTransformed),
          TransformSquare.bottomLeft(_onTransformed),
          TransformSquare.bottomCenter(_onTransformed),
          TransformSquare.bottomRight(_onTransformed),
        ],
      ),
    );
  }

  void _onTransformed(TransformDelta delta) {
    if (widget.layer.width + delta.width < 10) return;
    if (widget.layer.height + delta.height < 10) return;
    widget.layer.width += delta.width;
    widget.layer.height += delta.height;
    widget.layer.top += delta.top;
    widget.layer.left += delta.left;
    setState(() {});
  }
}
