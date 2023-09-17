import 'package:flutter/material.dart';
import 'package:graphics/view/layer_widget.dart';
import 'package:graphics/view/workspace_widget.dart';

void main() => runApp(const DraggableExampleApp());

class DraggableExampleApp extends StatelessWidget {
  const DraggableExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: WorkspaceWidget(),
      ),
    );
  }
}