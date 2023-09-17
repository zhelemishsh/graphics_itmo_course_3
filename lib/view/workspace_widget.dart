import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:graphics/models/workspace.dart';
import 'package:graphics/themes/app_colors.dart';
import 'package:graphics/view/layer_widget.dart';

import '../models/layer.dart';

class WorkspaceWidget extends StatefulWidget {
  const WorkspaceWidget({Key? key}) : super(key: key);

  @override
  WorkspaceWidgetState createState() {
    return WorkspaceWidgetState();
  }
}

class WorkspaceWidgetState extends State<WorkspaceWidget> {
  var workspace = Workspace();
  int id = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _workPanel(),
        ),
        Container(
          padding: const EdgeInsets.all(6),
          width: 250,
          color: AppColors.black,
          child: Column(
            children: [
              _addLayerButton(),
              _layersList(),
            ],
          )
        ),
      ],
    );
  }

  Widget _workPanel() {
    return Stack(
      children: workspace.layers.reversed.map((layer) {
        return LayerWidget(
          layer: layer,
        );
      }).toList(),
    );
  }

  Widget _addLayerButton() {
    return TextButton(
      onPressed: () {
        workspace.layers.insert(
          0, Layer(name: (++id).toString(), width: 200, height: 200),
        );
        setState(() {});
      },
      child: Container(
        color: Colors.green,
        child: Text(
          "Add layer",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }

  Widget _layersList() {
    return ReorderableListView.builder(
      shrinkWrap: true,
      itemCount: workspace.layers.length,
      buildDefaultDragHandles: false,
      onReorder: (oldIndex, newIndex) {
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }
        Layer layer = workspace.layers.removeAt(oldIndex);
        workspace.layers.insert(newIndex, layer);
        setState(() {});
      },
      proxyDecorator: _proxyDecorator,
      itemBuilder: (context, index) {
        return ReorderableDragStartListener(
          key: Key(workspace.layers[index].name),
          index: index,
          child: _layerPanel(workspace.layers[index], false),
        );
      },
    );
  }

  Widget _proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        final double animValue = Curves.easeInOut.transform(animation.value);
        final double scale = lerpDouble(1, 1.02, animValue)!;
        return Transform.scale(
          scale: scale,
          child: _layerPanel(workspace.layers[index], true),
        );
      },
      child: child,
    );
  }

  Widget _layerPanel(Layer layer, bool elevated) {
    return Container(
      padding: const EdgeInsets.all(3),
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.grey,
        boxShadow: elevated ? const [
          BoxShadow(blurRadius: 4)
        ] : [],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              layer.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          IconButton(
            onPressed: () {
              layer.isVisible = !layer.isVisible;
              setState(() {});
            },
            icon: Icon(
              layer.isVisible ? Icons.visibility : Icons.visibility_off,
              color: AppColors.lightOrange,
            ),
          ),
        ],
      ),
    );
  }
}