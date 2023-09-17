import 'package:flutter/material.dart';

class TransformSquare extends StatelessWidget {
  final Function(DragUpdateDetails details) onDragUpdate;

  const TransformSquare({
    Key? key,
    required this.onDragUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable(
      onDragUpdate: onDragUpdate,
      feedback: Container(),
      child: Container(
        width: 10,
        height: 10,
        color: Colors.lightGreenAccent,
      ),
    );
  }

  static Widget topLeft(Function(TransformDelta) onTransformed) {
    return Align(
      alignment: Alignment.topLeft,
      child: TransformSquare(
        onDragUpdate: (details) {
          var delta = TransformDelta();
          delta.left = details.delta.dx;
          delta.top = details.delta.dy;
          delta.width = -details.delta.dx;
          delta.height = -details.delta.dy;
          onTransformed(delta);
        },
      ),
    );
  }

  static Widget topCenter(Function(TransformDelta) onTransformed) {
    return Align(
      alignment: Alignment.topCenter,
      child: TransformSquare(
        onDragUpdate: (details) {
          var delta = TransformDelta();
          delta.top = details.delta.dy;
          delta.height = -details.delta.dy;
          onTransformed(delta);
        },
      ),
    );
  }

  static Widget topRight(Function(TransformDelta) onTransformed) {
    return Align(
      alignment: Alignment.topRight,
      child: TransformSquare(
        onDragUpdate: (details) {
          var delta = TransformDelta();
          delta.top = details.delta.dy;
          delta.width = details.delta.dx;
          delta.height = -details.delta.dy;
          onTransformed(delta);
        },
      ),
    );
  }

  static Widget centerLeft(Function(TransformDelta) onTransformed) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TransformSquare(
        onDragUpdate: (details) {
          var delta = TransformDelta();
          delta.left = details.delta.dx;
          delta.width = -details.delta.dx;
          onTransformed(delta);
        },
      ),
    );
  }

  static Widget centerRight(Function(TransformDelta) onTransformed) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: TransformSquare(
        onDragUpdate: (details) {
          var delta = TransformDelta();
          delta.left = details.delta.dx;
          delta.width = -details.delta.dx;
          delta.height = details.delta.dy;
          onTransformed(delta);
        },
      ),
    );
  }

  static Widget bottomCenter(Function(TransformDelta) onTransformed) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: TransformSquare(
        onDragUpdate: (details) {
          var delta = TransformDelta();
          delta.height += details.delta.dy;
          onTransformed(delta);
        },
      ),
    );
  }

  static Widget bottomRight(Function(TransformDelta) onTransformed) {
    return Align(
      alignment: Alignment.bottomRight,
      child: TransformSquare(
        onDragUpdate: (details) {
          var delta = TransformDelta();
          delta.width = details.delta.dx;
          delta.height = details.delta.dy;
          onTransformed(delta);
        },
      ),
    );
  }

  static Widget bottomLeft(Function(TransformDelta) onTransformed) {
    return Align(
      alignment: Alignment.centerRight,
      child: TransformSquare(
        onDragUpdate: (details) {
          var delta = TransformDelta();
          delta.width += details.delta.dx;
          onTransformed(delta);
        },
      ),
    );
  }
}

class TransformDelta {
  double width = 0;
  double height = 0;
  double left = 0;
  double top = 0;
}